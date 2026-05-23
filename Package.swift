// swift-tools-version:6.3
import PackageDescription

let package = Package(
    name: "swift-webrtc",
    platforms: [.iOS(.v16), .macOS(.v14)],
    products: [
        .library(
            name: "WebRTC",
            targets: ["WebRTC"],
        ),

        .library(
            name: "WebRTCDebug",
            targets: ["WebRTCDebug"],
        ),
    ],
    targets: [
        .binaryTarget(
            name: "WebRTC",
            url: "https://github.com/vitali-kurlovich/swift-webrtc/releases/download/untagged-07b82247eef550487b2f/WebRTC-v148.xcframework.zip",
            checksum: "0f25f7e9079f3a3f29eee15e2c429028faa0e5ee6324f2fe5c56ddefdfe8c0a8",
        ),

        .binaryTarget(
            name: "WebRTCDebug",
            url: "https://github.com/vitali-kurlovich/swift-webrtc/releases/download/untagged-07b82247eef550487b2f/WebRTC-v148-debug.xcframework.zip",
            checksum: "68a4db5399ab0a7b61d17edcf344cd7bd25758491df1da22cb4eda1f7b8237d3",
        ),
    ],
)
