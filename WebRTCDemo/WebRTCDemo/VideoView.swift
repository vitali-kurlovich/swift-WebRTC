//
//  VideoView.swift
//  WebRTCDemo
//
//  Created by Kurlovich Vitali on 5/26/26.
//

import SwiftUI
import WebRTC

#if os(macOS)

    struct VideoView: NSViewRepresentable {
        typealias NSViewType = WebRTC.RTCMTLNSVideoView

        func makeNSView(context _: Context) -> RTCMTLNSVideoView {
            NSViewType(frame: .zero)
        }

        func updateNSView(_ view: RTCMTLNSVideoView, context: Context) {
            // TODO:
            view.delegate = context.coordinator
        }

        func makeCoordinator() -> VideoViewCoordinator {
            VideoViewCoordinator()
        }
    }

    class VideoViewCoordinator: NSObject, RTCVideoViewDelegate {
        func videoView(_: any RTCVideoRenderer, didChangeVideoSize _: CGSize) {}
    }

#elseif os(iOS)

    struct VideoView: UIViewRepresentable {
        typealias UIViewType = WebRTC.RTCMTLVideoView

        @Environment(\.videoContentModeKey)
        var videoContentMode: UIView.ContentMode

        func makeUIView(context _: Context) -> RTCMTLVideoView {
            UIViewType(frame: .zero)
        }

        func updateUIView(_ view: UIViewType, context: Context) {
            view.delegate = context.coordinator
            view.videoContentMode = videoContentMode
        }

        func makeCoordinator() -> VideoViewCoordinator {
            VideoViewCoordinator()
        }
    }

    extension View {
        func videoContentMode(_ mode: UIView.ContentMode) -> some View {
            environment(\.videoContentModeKey, mode)
        }
    }

    class VideoViewCoordinator: NSObject, RTCVideoViewDelegate {
        func videoView(_: any RTCVideoRenderer, didChangeVideoSize _: CGSize) {}
    }

    struct VideoContentModeKey: EnvironmentKey {
        static let defaultValue: UIView.ContentMode = .scaleAspectFit
    }

    extension EnvironmentValues {
        var videoContentModeKey: UIView.ContentMode {
            get { self[VideoContentModeKey.self] }
            set { self[VideoContentModeKey.self] = newValue }
        }
    }

#endif
