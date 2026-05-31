//
//  Created by Kurlovich Vitali on 5/29/26.
//

import SwiftUI
import SwiftUIComponents
import SwiftWebRTC



extension SignalingState: @retroactive CustomStringConvertible {
    public var description: String {
        switch self {
        case .stable:
            return "Stable"
        case .haveLocalOffer:
            return "Have Local Offer"
        case .haveLocalPrAnswer:
            return "Have Local Pr Answer"
        case .haveRemoteOffer:
            return "Have Remote Offer"
        case .haveRemotePrAnswer:
            return "Have Remote Pr Answer"
        case .closed:
            return "Closed"
        case .unknown:
            return "Uncknown"
       
        }
    }
}

struct SignalingStateColorResolver: StatusIndicatorColorResolver {
    func resolveColor(for state: SignalingState) -> Color {
        switch state {
        case .stable:
            return Color.green
        case .haveLocalOffer:
            return Color.yellow
        case .haveLocalPrAnswer:
            return Color.yellow
        case .haveRemoteOffer:
            return Color.orange
        case .haveRemotePrAnswer:
            return Color.orange
        case .closed:
            return Color.secondary
        case .unknown:
            return Color.gray
        }
    }
}

#Preview {
    let resolver = SignalingStateColorResolver()
    PreviewStatusCollection(resolver: resolver)
}
