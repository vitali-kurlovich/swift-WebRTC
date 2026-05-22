class PackageGenerator:
    def __init__(self, repo, major, minor, patch, metadata, debugMetadata):
        super().__init__()
        self.baseUrl = f"https://github.com/{repo}"
        self.major = major
        self.minor = minor
        self.patch = patch

        self.metadata = metadata
        self.debugMetadata = debugMetadata

        self.packageName = repo.split("/")[1]

        if metadata.assetURL is None:
            raise Exception("assetURL is not set in the metadata")

        if debugMetadata.assetURL is None:
            raise Exception("assetURL is not set in the debugMetadata")

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
                    url: "{self.metadata.assetURL}",
                    checksum: "{self.metadata.checksum}"
                ),

                .binaryTarget(
                    name: "WebRTCDebug",
                    url: "{self.debugMetadata.assetURL}",
                    checksum: "{self.debugMetadata.checksum}"
                ),
            ]
        )
        """
