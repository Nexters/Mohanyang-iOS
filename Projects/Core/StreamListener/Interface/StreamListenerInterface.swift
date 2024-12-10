//
//  StreamListenerInterface.swift
//  StreamListener
//
//  Created by jihyun247 on 11/21/24.
//

import Foundation

import Dependencies
import DependenciesMacros

public protocol StreamListenerProtocol {
  func send<T: StreamTypeProtocol>(_ state: T) async
  func receive<T: StreamTypeProtocol>(_ type: T.Type) -> AsyncStream<T>
}

@DependencyClient
public struct StreamListener {
  public var protocolAdapter: StreamListenerProtocol

  public init(protocolAdapter: StreamListenerProtocol) {
    self.protocolAdapter = protocolAdapter
  }
}

extension StreamListener: TestDependencyKey {
  public static let previewValue = Self(protocolAdapter: StreamListenerTestImpl())
  public static let testValue = Self(protocolAdapter: StreamListenerTestImpl())
}

private struct StreamListenerTestImpl: StreamListenerProtocol {
  func send<T: StreamTypeProtocol>(_ state: T) async {}
  func receive<T: StreamTypeProtocol>(_ type: T.Type) -> AsyncStream<T> { .never }
}

/*
 // 서버 상태 변경 시
 await send(ServerState.requestStarted)
어떤 stream에 어떤 state를 보낼 것인지

 // 스트림 구독
 let serverStateStream: AsyncStream<ServerState> = receive(for: ServerState.self)
 어떤 stream을 구독할 것인지 , , , , . . ..
 */

/*
 catCore - serverstate 네트워크 에러 send
 catcore - send와 동시에 core.action에 networkerror 같은 action만들고 어떤 api인지 같이 보냄
 catcore - core.action.networkerror([api종류]) 에선, retry 구독, 스트림 받으면 어떤 api인지 알고잇으니 재요청 하면됨 (재요청하고나선 구독한 스트림 꼭 종료)
appCore - serverstate 네트워크 에러 receive
 appCore - 네트워크에러 receive 네트워크에러뷰 띄움
 retryCore - 재시도 뷰에서 재시도버튼 클릭 시 재시도 send
 */

/*
 해야할 것: receive, send 조금 더 수정하기 . . . ..
 */
