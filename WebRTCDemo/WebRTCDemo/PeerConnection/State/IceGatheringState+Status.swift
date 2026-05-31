//
//  Created by Kurlovich Vitali on 5/29/26.
//

import SwiftUI
import SwiftUIComponents
import SwiftWebRTC


extension IceGatheringState: @retroactive CustomStringConvertible {
    public var description: String {
        switch self {
        case .new:
            return "New"
        case .gathering:
            return "Gathering"
        case .complete:
            return "Complete"
        case .unknown:
            return "Uncknown"
        
        }
    }
}

struct IceGatheringStateColorResolver: StatusIndicatorColorResolver {
    func resolveColor(for state: IceGatheringState) -> Color {
        switch state {
        case .new:
            return Color.secondary
        case .gathering:
            return Color.orange
        case .complete:
            return Color.accentColor
        case .unknown:
            return Color.secondary
        }
    }
}

#Preview {
    let resolver = IceGatheringStateColorResolver()
    PreviewStatusCollection(resolver: resolver)
}
