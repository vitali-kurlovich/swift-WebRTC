//
//  Created by Kurlovich Vitali on 5/31/26.
//

import WebRTC

/** Represents the stats output level. */
public enum StatsOutputLevel: Int8, Hashable, CaseIterable, Sendable {
    case standard = 0

    case debug = 1

    case unknown = -1
}

extension StatsOutputLevel {
    init(_ state: RTCStatsOutputLevel) {
        switch state {
        case .standard:
            self = .standard
        case .debug:
            self = .debug
        @unknown default:
            self = .unknown
        }
    }
}
