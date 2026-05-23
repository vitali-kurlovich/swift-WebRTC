import json
import logging
import os
import subprocess
from dataclasses import dataclass
from datetime import datetime, timedelta

import git
import requests
from chromiumdash import ChromiumdashRepository
from githubapi import GitHubApiRepository
from Metadata import Metadata
from PackageGenerator import PackageGenerator


@dataclass
class NextReleaseResult:
    version: int
    releaseDate: datetime
    branch: str


class ReleaseManagerException(Exception):
    pass


class ShellException(Exception):
    def __init__(self, message, code):
        super().__init__(message)
        self.message = message
        self.code = code

    def __str__(self):
        return f"{self.message} return: ({self.code})"


class ReleaseManager:
    def __init__(self, major, patch):
        super().__init__()

        GITHUB_TOKEN = os.environ.get("GITHUB_TOKEN")
        GITHUB_REPO = os.environ.get("GITHUB_REPOSITORY")

        self.repo = GITHUB_REPO
        self.major = major
        self.patch = patch
        self.gitHubApi = GitHubApiRepository(repo=GITHUB_REPO, token=GITHUB_TOKEN)
        self.chromiumDashApi = ChromiumdashRepository()

        self.logger = logging.getLogger(__name__)

        self.rootDir = os.environ.get("ROOT_DIR")
        self.releaseDir = os.environ.get("OUTPUT_RELEASE_DIR")
        self.debugDir = os.environ.get("OUTPUT_DEBUG_DIR")

    def run(self):
        self._raiseCheckEnv()

        self.logger.info("Fetch next version...")
        nextRelease = self._getNextRelease()

        if not self._isReleaseAvailable(nextRelease):
            self.logger.info("Next version is not out yet. Skipping build")
            os._exit(os.EX_OK)

        self.logger.info(f"New version ({nextRelease.version}) is available to build")
        self._build(nextRelease.branch)
        self.logger.info("WebRTC build successful")

        metadata = self._buildMetadata(self.releaseDir)
        debugmetadata = self._buildMetadata(self.debugDir)

        self.logger.info("Creating new release draft...")
        draft = self._createReleaseDraft(nextRelease, metadata, debugmetadata)

        self.logger.info("Upload asset to github...")

        assetName = f"WebRTC-v{nextRelease.version}.xcframework.zip"

        assetDebugName = f"WebRTC-v{nextRelease.version}-debug.xcframework.zip"

        metadata.assetURL = self._uploadReleaseAsset(
            self.releaseDir, draft, metadata, assetName
        )

        debugmetadata.assetURL = self._uploadReleaseAsset(
            self.debugDir, draft, debugmetadata, assetDebugName
        )

        self.logger.info("Create new branch with code changes")
        releaseBranch = self._createLocalBranch(nextRelease)

        self.logger.info("Update Package.swift")
        self._generatePackage(nextRelease, metadata, debugmetadata)

        self.logger.info("Commiting and pushing code to remote")
        self._commitChanges(releaseBranch, nextRelease)

        self.logger.info("Create Pull Request")
        self._pullRequest(nextRelease, releaseBranch)

        self.logger.info("Done.")

    def _build(self, branch):
        os.environ["BRANCH"] = branch
        process = subprocess.run(["sh", "scripts/build.sh"])
        result = process.returncode
        if result != 0:
            raise ShellException(
                f"Build script return non-zero exit code: {result}", result
            )

    def _createReleaseDraft(self, release, metadata, debugmetadata):
        body = f"Release notes: https://webrtc.googlesource.com/src.git/+log/refs/{metadata.branch}/\n"
        body += f"WebRTC Branch: [{metadata.branch}](https://chromium.googlesource.com/external/webrtc/+log/{metadata.branch})\n"
        body += f"WebRTC Commit: `{metadata.commit}`\n\n"
        body += f"SHA 256 checksum: `{metadata.checksum}`\n"
        body += f"Debug SHA 256 checksum: `{debugmetadata.checksum}`\n"

        fields = {
            "name": f"v{release.version}",
            "tag_name": f"{self.major}.{release.version}.{self.patch}",
            "draft": True,
            "body": body,
        }

        return self.gitHubApi.postReleaseDraft(fields)

    def _uploadReleaseAsset(self, releaseDir, releaseDraft, metadata, assetName):
        assetPath = os.path.join(releaseDir, metadata.filename)
        uploadURL = releaseDraft["upload_url"]
        result = self.gitHubApi.uploadReleaseAsset(uploadURL, assetPath, assetName)
        self.logger.info(
            f"Successfully created new draft release in github: {releaseDraft['url']}"
        )

        return result["browser_download_url"]

    def _createLocalBranch(self, nextRelease):
        releaseBranch = f"release-v{nextRelease.version}"

        process = subprocess.run(["git", "checkout", "-b", releaseBranch])
        result = process.returncode

        if result != 0:
            raise ShellException(
                f"git checkout return non-zero exit code: {result}", result
            )
        self.logger.info("WebRTC build successful.")

        return releaseBranch

    def _generatePackage(self, release, metadata, debugmetadata):
        generator = PackageGenerator(
            repo=self.repo,
            major=self.major,
            minor=release.version,
            patch=self.patch,
            metadata=metadata,
            debugMetadata=debugmetadata,
        )

        content = generator.content()
        self.logger.debug(f"Content for Package.swift: {content}")
        filepath = f"{self.rootDir}/Package.swift"

        with open(filepath, "w") as f:
            f.write(content)

        process = subprocess.run(["swiftformat", filepath])

        result = process.returncode

        if result != 0:
            raise ShellException(
                f"swiftformat return non-zero exit code: {result}",
                result,
            )

    def _commitChanges(self, releaseBranch: str, nextRelease: NextReleaseResult):

        git.add("Package.swift")
        git.commit(f'"Updated files for release v{nextRelease.version}"')
        git.push(releaseBranch)

    def _pullRequest(self, release, head):
        body = {
            "title": f"Release v{release.version}",
            "head": head,
            "base": "main",
            "body": f"Updated files for release v{release.version}.",
        }

        self.gitHubApi.createPullRequest(body)

    def _raiseCheckEnv(self):
        if self.rootDir is None:
            raise ReleaseManagerException("ROOT_DIR is not set")

        if self.releaseDir is None:
            raise ReleaseManagerException("OUTPUT_RELEASE_DIR is not set")

        if self.debugDir is None:
            raise ReleaseManagerException("OUTPUT_DEBUG_DIR is not set")

        if self.gitHubApi.repo is None:
            raise ReleaseManagerException("GITHUB_REPO is not set")

        if self.gitHubApi.token is None:
            raise ReleaseManagerException("GITHUB_TOKEN is not set")

    def _getNextRelease(self):
        (latestReleaseVersion, latestReleaseDate) = self.gitHubApi.fetchLastRelease()
        stableMilestone = self.chromiumDashApi.fetchStableMilestone()

        # Get the current stable milestone
        nextReleaseVersion = max(latestReleaseVersion + 1, stableMilestone)
        if nextReleaseVersion > latestReleaseVersion + 1:
            self.logger.info(
                f"Current stable milestone is {stableMilestone}, skipping ahead from {latestReleaseVersion + 1}"
            )

        milestones = self.chromiumDashApi.fetchMilestoneSchedule(nextReleaseVersion)
        releases = self.chromiumDashApi.fetchMilestoneReleases(nextReleaseVersion)

        nextReleaseDate = datetime.fromisoformat(
            milestones["mstones"][0]["stable_date"]
        )
        nextReleaseBranch = "branch-heads/" + releases[0]["webrtc_branch"]

        self.logger.info(
            f"Next release: version {nextReleaseVersion}, date: {nextReleaseDate}, branch: {nextReleaseBranch}"
        )

        return NextReleaseResult(
            version=nextReleaseVersion,
            releaseDate=nextReleaseDate,
            branch=nextReleaseBranch,
        )

    def _isReleaseAvailable(self, release):
        return datetime.today() >= (release.releaseDate + timedelta(days=1))

    def _buildMetadata(self, outputDir):
        with open(f"{outputDir}/metadata.json", "r") as f:
            jsonData = json.loads(f.read())
            return Metadata(
                filename=jsonData["file"],
                checksum=jsonData["checksum"],
                commit=jsonData["commit"],
                branch=jsonData["branch"],
                assetURL=None,
            )
