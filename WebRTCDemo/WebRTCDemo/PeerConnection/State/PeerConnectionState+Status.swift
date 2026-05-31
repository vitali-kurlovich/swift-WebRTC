//
//  Created by Kurlovich Vitali on 5/29/26.
//

import SwiftUI
import SwiftUIComponents
import SwiftWebRTC



extension PeerConnectionState: @retroactive CustomStringConvertible {
    public var description: String {
        switch self {
        case .new:
            return "New"
        case .connecting:
            return "Connecting"
        case .connected:
            return "Connected"
        case .disconnected:
            return "Disconnected"
        case .failed:
            return "Failed"
        case .closed:
            return "Closed"
        case .unknown:
            return "Uncknown"
        }
    }
}

struct PeerConnectionStatusColorResolver: StatusIndicatorColorResolver {
    func resolveColor(for state: PeerConnectionState) -> Color {
        switch state {
        case .new:
            return Color.accentColor
        case .connecting:
            return Color.orange
        case .connected:
            return Color.green
        case .disconnected:
            return Color.secondary
        case .failed:
            return Color.red
        case .closed:
            return Color.secondary
        case .unknown:
            return Color.secondary
        }
    }
}

#Preview {
    let resolver = PeerConnectionStatusColorResolver()
    PreviewStatusCollection(resolver: resolver)
}
