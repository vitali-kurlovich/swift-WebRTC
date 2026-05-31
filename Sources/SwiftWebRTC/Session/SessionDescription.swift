//
//  Created by Kurlovich Vitali on 5/31/26.
//

import WebRTC

/**
 * Represents the session description type. This exposes the same types that are
 * in C++, which doesn't include the rollback type that is in the W3C spec.
 */
public enum SdpType: Int8, Hashable, Codable, CaseIterable, Sendable {
    case offer = 0

    case prAnswer = 1

    case answer = 2

    case rollback = 3
}

extension SdpType {
    init(_ type: RTCSdpType) {
        switch type {
        case .offer:
            self = .offer
        case .prAnswer:
            self = .prAnswer
        case .answer:
            self = .answer
        case .rollback:
            self = .rollback
        @unknown default:
            assertionFailure("Unknown RTCSdpType")
            self = .offer
        }
    }
}

extension RTCSdpType {
    init(_ type: SdpType) {
        switch type {
        case .offer:
            self = .offer
        case .prAnswer:
            self = .prAnswer
        case .answer:
            self = .answer
        case .rollback:
            self = .rollback
        }
    }
}

public struct SessionDescription: Hashable, Codable, Sendable {
    /** The type of session description. */
    public let type: SdpType

    /** The SDP string representation of this session description. */
    public let sdp: String

    public init(type: SdpType, sdp: String) {
        self.type = type
        self.sdp = sdp
    }
}

public extension SessionDescription {
    static func string(for type: SdpType) -> String {
        RTCSessionDescription.string(for: .init(type))
    }

    static func type(for string: String) -> SdpType {
        .init(RTCSessionDescription.type(for: string))
    }
}

extension SessionDescription {
    init(_ desc: RTCSessionDescription) {
        self.init(type: .init(desc.type), sdp: desc.sdp)
    }
}

extension RTCSessionDescription {
    convenience init(_ desc: SessionDescription) {
        self.init(type: .init(desc.type), sdp: desc.sdp)
    }
}
