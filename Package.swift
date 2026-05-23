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
            url: "https://github.com/vitali-kurlovich/swift-webrtc/releases/download/0.148.0/WebRTC-2026-05-23T16-16-44.xcframework.zip",
            checksum: "539508f19109c6488b56c237c2e04cfecb37400f3bad9cfcdf572a017aa4e5e5",
        ),

        .binaryTarget(
            name: "WebRTCDebug",
            url: "https://github.com/vitali-kurlovich/swift-webrtc/releases/download/0.148.0/WebRTC-2026-05-23T16-36-03-debug.xcframework.zip",
            checksum: "4737d05b2d09fc5bdfe2388041f8d8ee79bf0588b762abcda160d6ddf6d0f3b1",
        ),
    ],
)
