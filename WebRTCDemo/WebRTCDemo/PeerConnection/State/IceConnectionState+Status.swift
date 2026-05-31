//
//  Created by Kurlovich Vitali on 5/29/26.
//

import SwiftUI
import SwiftUIComponents
import SwiftWebRTC



extension IceConnectionState: @retroactive CustomStringConvertible {
    public var description: String {
        switch self {
        case .new:
            return "New"
        case .checking:
            return "Checking"
        case .connected:
            return "Connected"
        case .completed:
            return "Completed"
        case .failed:
            return "Failed"
        case .disconnected:
            return "Disconnected"
        case .closed:
            return "Closed"
        case .count:
            return "Count"
        case .unknown:
            return "Uncknown"
        }
    }
}

struct IceConnectionStateColorResolver: StatusIndicatorColorResolver {
    func resolveColor(for state: IceConnectionState) -> Color {
        switch state {
        case .new:
            return Color.orange
        case .checking:
            return Color.yellow
        case .connected:
            return Color.green
        case .completed:
            return Color.green
        case .failed:
            return Color.red
        case .disconnected:
            return Color.secondary
        case .closed:
            return Color.secondary
        case .count:
            return Color.secondary
       
        case .unknown:
            return Color.secondary
        }
    }
}

#Preview {
    let resolver = IceConnectionStateColorResolver()
    PreviewStatusCollection(resolver: resolver)
}
