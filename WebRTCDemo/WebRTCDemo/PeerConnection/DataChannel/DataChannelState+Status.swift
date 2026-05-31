//
//  Created by Kurlovich Vitali on 5/30/26.
//

import SwiftUI
import SwiftUIComponents
import SwiftWebRTC


extension DataChannelState: @retroactive CustomStringConvertible {
    public var description: String {
        switch self {
        case .connecting:
            return "Connecting"
        case .open:
            return "Open"
        case .closing:
            return "Closing"
        case .closed:
            return "Closed"
        case .unknown:
            return "Uncknown"
        }
    }
}

struct DataChannelStateColorResolver: StatusIndicatorColorResolver {
    func resolveColor(for state: DataChannelState) -> Color {
        switch state {
        case .connecting:
            return Color.orange
        case .open:
            return Color.green
        case .closing:
            return Color.red
        case .closed:
            return Color.secondary
        case .unknown:
            return Color.secondary
        }
    }
}

#Preview {
    let resolver = DataChannelStateColorResolver()
    PreviewStatusCollection(resolver: resolver)
}
