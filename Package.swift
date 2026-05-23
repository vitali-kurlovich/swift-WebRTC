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
            url: "https://github.com/vitali-kurlovich/swift-webrtc/releases/download/0.148.0/WebRTC-v148.xcframework.zip",
            checksum: "3cd2dd96f87a50a46e0be28c612598e85593db798cbe50dd670459034631ee72",
        ),

        .binaryTarget(
            name: "WebRTCDebug",
            url: "https://github.com/vitali-kurlovich/swift-webrtc/releases/download/0.148.0/WebRTC-v148-debug.xcframework.zip",
            checksum: "02ec1e70aa0900d33e2576241a157b74603fc06c39c1db2dd57fe21b1f86afe3",
        ),
    ],
)
