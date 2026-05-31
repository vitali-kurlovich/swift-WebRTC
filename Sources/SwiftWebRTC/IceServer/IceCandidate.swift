//
//  Created by Kurlovich Vitali on 6/1/26.
//

import WebRTC

public struct IceCandidate: Hashable, Codable, Sendable {
    /** The SDP string for this candidate. */
    public let sdp: String

    /**
     * The index (starting at zero) of the media description this candidate is
     * associated with in the SDP.
     */
    public let sdpMLineIndex: Int32

    /**
     * If present, the identifier of the "media stream identification" for the media
     * component this candidate is associated with.
     */
    public let sdpMid: String?

    /** The URL of the ICE server which this candidate is gathered from. */
    public let serverUrl: String?

    /**
     * Initialize an IceCandidate from SDP.
     */
    public init(sdp: String, sdpMLineIndex: Int32, sdpMid: String?, serverUrl: String? = nil) {
        self.sdp = sdp
        self.sdpMLineIndex = sdpMLineIndex
        self.sdpMid = sdpMid
        self.serverUrl = serverUrl
    }
}

extension IceCandidate {
    init(_ candidate: RTCIceCandidate) {
        self.init(sdp: candidate.sdp,
                  sdpMLineIndex: candidate.sdpMLineIndex,
                  sdpMid: candidate.sdpMid,
                  serverUrl: candidate.serverUrl)
    }
}

extension RTCIceCandidate {
    convenience init(_ candidate: IceCandidate) {
        self.init(sdp: candidate.sdp,
                  sdpMLineIndex: candidate.sdpMLineIndex,
                  sdpMid: candidate.sdpMid)
    }
}
