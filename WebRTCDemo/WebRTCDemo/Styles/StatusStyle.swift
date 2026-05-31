//
//  Created by Kurlovich Vitali on 5/30/26.
//

import SwiftUI
import SwiftUIComponents
import SwiftWebRTC

extension View {
    func useDefaultStatusStyle() -> some View {
        statusStyle(
            DefaultStatusStyle(DataChannelStateColorResolver())
        )
        .statusStyle(
            DefaultStatusStyle(IceConnectionStateColorResolver())
        )
        .statusStyle(
            DefaultStatusStyle(IceGatheringStateColorResolver())
        )
        .statusStyle(
            DefaultStatusStyle(SignalingStateColorResolver())
        )
        .statusStyle(
            DefaultStatusStyle(PeerConnectionStatusColorResolver())
        )
    }

    func useDefaultStatusCompactStyle() -> some View {
        statusStyle(
            DefaultStatusCompactStyle(DataChannelStateColorResolver())
        )
        .statusStyle(
            DefaultStatusCompactStyle(IceConnectionStateColorResolver())
        )
        .statusStyle(
            DefaultStatusCompactStyle(IceGatheringStateColorResolver())
        )
        .statusStyle(
            DefaultStatusCompactStyle(SignalingStateColorResolver())
        )
        .statusStyle(
            DefaultStatusCompactStyle(PeerConnectionStatusColorResolver())
        )
    }

    func useDefaultStatusGlassStyle() -> some View {
        statusStyle(
            DefaultStatusGlassStyle(DataChannelStateColorResolver())
        )
        .statusStyle(
            DefaultStatusGlassStyle(IceConnectionStateColorResolver())
        )
        .statusStyle(
            DefaultStatusGlassStyle(IceGatheringStateColorResolver())
        )
        .statusStyle(
            DefaultStatusGlassStyle(SignalingStateColorResolver())
        )
        .statusStyle(
            DefaultStatusGlassStyle(PeerConnectionStatusColorResolver())
        )
    }

    func useDefaultStatusCompactGlassStyle() -> some View {
        statusStyle(
            DefaultStatusCompactGlassStyle(DataChannelStateColorResolver())
        )
        .statusStyle(
            DefaultStatusCompactGlassStyle(IceConnectionStateColorResolver())
        )
        .statusStyle(
            DefaultStatusCompactGlassStyle(IceGatheringStateColorResolver())
        )
        .statusStyle(
            DefaultStatusCompactGlassStyle(SignalingStateColorResolver())
        )
        .statusStyle(
            DefaultStatusCompactGlassStyle(PeerConnectionStatusColorResolver())
        )
    }
}

private struct PreviewStatus<State: Equatable & CustomStringConvertible & CaseIterable>: View {
    let text: String
    let state: State

    var body: some View {
        VStack(alignment: .leading) {
            Text(text).font(.caption)
            Status(state: state)
        }
    }
}

private extension PreviewStatus {
    init(_ type: State.Type) {
        self.init(text: String(describing: type), state: type.allCases.first!)
    }
}

private struct PreviewStatusCollection: View {
    var body: some View {
        HStack {
            PreviewStatus(DataChannelState.self)
            PreviewStatus(IceConnectionState.self)
            PreviewStatus(IceGatheringState.self)
            PreviewStatus(PeerConnectionState.self)
            PreviewStatus(SignalingState.self)
        }
    }
}

#Preview {
    ScrollView {
        VStack(spacing: 44) {
            VStack {
                Text("useDefaultStatusStyle")
                PreviewStatusCollection()
                    .useDefaultStatusStyle()
            }

            VStack {
                Text("useDefaultStatusCompactStyle")
                PreviewStatusCollection()
                    .useDefaultStatusCompactStyle()
            }

            VStack {
                Text("useDefaultStatusGlassStyle")
                PreviewStatusCollection()
                    .useDefaultStatusGlassStyle()
            }

            VStack {
                Text("useDefaultStatusCompactGlassStyle")
                PreviewStatusCollection()
                    .useDefaultStatusCompactGlassStyle()
            }

            // ()
        }
    }.safeAreaPadding()
}
