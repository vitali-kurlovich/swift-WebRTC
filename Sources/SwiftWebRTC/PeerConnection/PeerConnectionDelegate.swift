//
//  Created by Kurlovich Vitali on 5/28/26.
//

import WebRTC

final class PeerConnectionDelegate: NSObject, RTCPeerConnectionDelegate {
    weak var connection: PeerConnection? {
        didSet {
            peerConnection?.delegate = self
        }
    }

    private var peerConnection: RTCPeerConnection? {
        connection?.peerConnection
    }

    func peerConnection(_ peerConnection: RTCPeerConnection, didChange newState: RTCPeerConnectionState) {
        assert(self.peerConnection === peerConnection)
        connection?.connectionState = .init(newState)
    }

    func peerConnection(_ peerConnection: RTCPeerConnection, didChange stateChanged: RTCSignalingState) {
        assert(self.peerConnection === peerConnection)
        connection?.signalingState = .init(stateChanged)
    }

    func peerConnection(_ peerConnection: RTCPeerConnection, didChange newState: RTCIceConnectionState) {
        assert(self.peerConnection === peerConnection)

        connection?.iceConnectionState = .init(newState)
    }

    func peerConnection(_ peerConnection: RTCPeerConnection, didChange newState: RTCIceGatheringState) {
        assert(self.peerConnection === peerConnection)
        connection?.iceGatheringState = .init(newState)
    }

    func peerConnection(_ peerConnection: RTCPeerConnection, didAdd _: RTCMediaStream) {
        assert(self.peerConnection === peerConnection)
    }

    func peerConnection(_ peerConnection: RTCPeerConnection, didRemove _: RTCMediaStream) {
        assert(self.peerConnection === peerConnection)
    }

    func peerConnectionShouldNegotiate(_ peerConnection: RTCPeerConnection) {
        assert(self.peerConnection === peerConnection)
    }

    func peerConnection(_ peerConnection: RTCPeerConnection, didGenerate _: RTCIceCandidate) {
        assert(self.peerConnection === peerConnection)
    }

    func peerConnection(_ peerConnection: RTCPeerConnection, didRemove _: [RTCIceCandidate]) {
        assert(self.peerConnection === peerConnection)
    }

    func peerConnection(_ peerConnection: RTCPeerConnection, didOpen _: RTCDataChannel) {
        assert(connection === peerConnection)
    }
}

/*

 /*
  * The name of the sub-protocol used with this data channel, if any. Otherwise
  * this returns an empty string.
  */
 open var `protocol`: String { get }

 /*  The identifier for this data channel. */
 open var channelId: Int32 { get }

 /*
  * The number of bytes of application data that have been queued using
  * `sendData:` but that have not yet been transmitted to the network.
  */
 open var bufferedAmount: UInt64 { get }

 /*  The delegate for this data channel. */
 weak open var delegate: (any RTCDataChannelDelegate)?

 /*  Closes the data channel. */
 open func close()

 /*  Attempt to send `data` on this data channel's underlying data transport. */
 open func sendData(_ data: RTCDataBuffer) -> Bool

 */
