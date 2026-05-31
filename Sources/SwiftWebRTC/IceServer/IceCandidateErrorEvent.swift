//
//  Created by Kurlovich Vitali on 6/1/26.
//

import WebRTC

public struct IceCandidateErrorEvent: Hashable, Codable, Sendable {
    /** The local IP address used to communicate with the STUN or TURN server. */
    public let address: String

    /** The port used to communicate with the STUN or TURN server. */
    public let port: Int32

    /** The STUN or TURN URL that identifies the STUN or TURN server for which the
     * failure occurred. */
    public let url: String

    /** The numeric STUN error code returned by the STUN or TURN server. If no host
     * candidate can reach the server, errorCode will be set to the value 701 which
     * is outside the STUN error code range. This error is only fired once per
     * server URL while in the RTCIceGatheringState of "gathering". */
    public let errorCode: Int32

    /** The STUN reason text returned by the STUN or TURN server. If the server
     * could not be reached, errorText will be set to an implementation-specific
     * value providing details about the error. */
    public let errorText: String
}

extension IceCandidateErrorEvent {
    init(_ event: RTCIceCandidateErrorEvent) {
        self.init(address: event.address,
                  port: event.port,
                  url: event.url,
                  errorCode: event.errorCode,
                  errorText: event.errorText)
    }
}
