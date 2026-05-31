//
//  Created by Kurlovich Vitali on 5/28/26.
//

import WebRTC

final class DataChannelDelegate: NSObject, RTCDataChannelDelegate {
    weak var channel: DataChannel? {
        didSet {
            channel?.channel.delegate = self
        }
    }

    private let handlersStorage = DataChannelHandlersStorage()

    private var dataChannel: RTCDataChannel? {
        channel?.channel
    }

    func dataChannelDidChangeState(_ dataChannel: RTCDataChannel) {
        assert(self.dataChannel === dataChannel)

        channel?.readyState = DataChannelState(dataChannel.readyState)
    }

    func dataChannel(_ dataChannel: RTCDataChannel, didReceiveMessageWith buffer: RTCDataBuffer) {
        assert(self.dataChannel === dataChannel)

        let buffer = DataBuffer(data: buffer.data, isBinry: buffer.isBinary)
        Task { [handlersStorage] in
            await handlersStorage.didReceive(buffer)
        }
    }

    func messages() -> AsyncStream<DataBuffer> {
        let uuid = UUID()

        let storage = handlersStorage

        return AsyncStream { continuation in
            continuation.onTermination = { @Sendable _ in
                Task {
                    await storage.remove(with: uuid)
                }
            }

            let handler = DataChannelHandler { buffer in
                continuation.yield(buffer)
            }

            Task {
                await storage.add(handler, with: uuid)
            }
        }
    }
}

private struct DataChannelHandler {
    let handler: @Sendable (DataBuffer) -> Void

    func receive(_ buffer: DataBuffer) {
        handler(buffer)
    }
}

private actor DataChannelHandlersStorage {
    private var handlers: [UUID: DataChannelHandler] = [:]

    func add(_ handler: DataChannelHandler, with uuid: UUID) {
        handlers[uuid] = handler
    }

    func remove(with uuid: UUID) {
        handlers[uuid] = nil
    }

    func didReceive(_ buffer: DataBuffer) {
        Task {
            for (_, handler) in handlers {
                handler.receive(buffer)
            }
        }
    }
}
