from datetime import datetime

from Metadata import Metadata
from ReleaseManager import NextReleaseResult, ReleaseManager

metadata = Metadata(
    filename="WebRTC-v148.xcframework.zip",
    checksum="473bf4b0474a937a1d195684526ab1b8d75b2fe13406fb409da3d15b109ad7d6",
    commit="",
    branch="",
    assetURL=None,
)

metadataDebug = Metadata(
    filename="WebRTC-v148-debug.xcframework.zip",
    checksum="680167b6a6c460bf653644d190479b137d3ccb9f337db6fdc9289822678242fd",
    commit="",
    branch="",
    assetURL=None,
)

release = NextReleaseResult(
    version=148,
    releaseDate=datetime.today(),
    branch="",
)

releaseManager = ReleaseManager(major="0", patch="0")

releaseManager._generatePackage(release, metadata, metadataDebug)
