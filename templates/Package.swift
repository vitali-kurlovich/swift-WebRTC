// swift-tools-version:6.3

import PackageDescription

let package = Package(
    name: "%{name}%",
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
            url: "%{url}%",
            checksum: "%{checksum}%",
        ),

        .binaryTarget(
            name: "WebRTCDebug",
            url: "%{url_debug}%",
            checksum: "%{checksum_debug}%",
        ),
    ],
)
