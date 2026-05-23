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
            url: "None",
            checksum: "473bf4b0474a937a1d195684526ab1b8d75b2fe13406fb409da3d15b109ad7d6",
        ),

        .binaryTarget(
            name: "WebRTCDebug",
            url: "None",
            checksum: "680167b6a6c460bf653644d190479b137d3ccb9f337db6fdc9289822678242fd",
        ),
    ],
)
