// swift-tools-version:6.3

import PackageDescription

let package = Package(
    name: "swift-webrtc",
    platforms: [.iOS(.v16), .macOS(.v14)],
    products: [
        .library(
            name: "WebRTC",
            targets: ["WebRTC"],
        )
    ],
    targets: [
        .binaryTarget(
            name: "WebRTC",
            url: "https://github.com/vitali-kurlovich/swift-webrtc/releases/download/0.148.0/WebRTC-v148.xcframework.zip",
            checksum: "cdc1a0ec25159aff9bd3f773c46f4a71846e15d433ad4d01c84fdab8f40200b4",
        )
    ],
)
