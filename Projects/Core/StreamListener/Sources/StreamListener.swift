//
//  StreamListener.swift
//  StreamListener
//
//  Created by jihyun247 on 11/21/24.
//

import Foundation

import StreamListenerInterface

import Dependencies

//extension StreamListener: DependencyKey {
//  public static let liveValue: StreamListener = .live()
//
//  public static func live() -> StreamListener {
//
//    actor ContinuationActor {
//      var continuation: AsyncStream<ServerState>.Continuation?
//
//      func set(_ newContinuation: AsyncStream<ServerState>.Continuation) {
//        continuation = newContinuation
//      }
//
//      func yield(_ state: ServerState) {
//        continuation?.yield(state)
//      }
//    }
//
//    let continuationActor = ContinuationActor()
//    let asyncStream = AsyncStream<ServerState> { continuation in
//      Task { await continuationActor.set(continuation) }
//    }
//
//    return StreamListener(
//      sendServerState: { state in
//        await continuationActor.yield(state)
//      },
//      updateServerState: {
//        return asyncStream
//      }
//    )
//  }
//}

 extension StreamListener: DependencyKey {
   public static let liveValue: StreamListener = .live()

   public static func live() -> StreamListener {
     actor ContinuationActor {
       var continuations: [StreamType: AsyncStream<AnyHashable>.Continuation] = [:]

       func set(_ type: StreamType, continuation: AsyncStream<AnyHashable>.Continuation) {
         continuations[type] = continuation
       }

       func yield(_ type: StreamType, value: AnyHashable) {
         continuations[type]?.yield(value)
       }
     }

     actor StreamActor {
       var streams: [StreamType: AsyncStream<AnyHashable>] = [:]

       func set(_ type: StreamType, stream: AsyncStream<AnyHashable>) {
         streams[type] = stream
       }

       func get(_ type: StreamType) -> AsyncStream<AnyHashable> {
         return streams[type] ?? .never
       }
     }

     let continuationActor = ContinuationActor()
     let streamActor = StreamActor()

     return StreamListener(
       initStream: { type in
         let stream = AsyncStream<AnyHashable> { continuation in
           Task { await continuationActor.set(type, continuation: continuation) }
         }
         await streamActor.set(type, stream: stream)
       },
       sendValue: { type in
         await continuationActor.yield(type, value: type.hashValue)//스트림타입의 밸류 자료형)
       },
       receiveStream: { type in
         return await streamActor.get(type)
       }
     )
   }
 }
