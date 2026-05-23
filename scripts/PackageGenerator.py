from Metadata import Metadata


class PackageGenerator:
    def __init__(
        self, repo, major, minor, patch, metadata: Metadata, debugMetadata: Metadata
    ):
        super().__init__()
        self.baseUrl = f"https://github.com/{repo}"
        self.major = major
        self.minor = minor
        self.patch = patch

        self.metadata = metadata
        self.debugMetadata = debugMetadata

        self.packageName = repo.split("/")[1]
        self.tag = f"{major}.{minor}.{patch}"

    def _downloadURL(self, metadata: Metadata):
        f"{self.baseUrl}/releases/download/{self.tag}/{metadata.filename}"

    def content(self):
        return f"""// swift-tools-version:6.3
        import PackageDescription

        let package = Package(
            name: "{self.packageName}",
            platforms: [.iOS(.v16), .macOS(.v14)],
            products: [
                .library(
                    name: "WebRTC",
                    targets: ["WebRTC"]),

                .library(
                    name: "WebRTCDebug",
                    targets: ["WebRTCDebug"]),
            ],
            targets: [
                .binaryTarget(
                    name: "WebRTC",
                    url: "{self._downloadURL(self.metadata)}",
                    checksum: "{self.metadata.checksum}"
                ),

                .binaryTarget(
                    name: "WebRTCDebug",
                    url: "{self._downloadURL(self.debugMetadata)}",
                    checksum: "{self.debugMetadata.checksum}"
                ),
            ]
        )
        """
