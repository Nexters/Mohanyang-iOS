//
//  NetworkErrorView.swift
//  ErrorFeature
//
//  Created by 김지현 on 11/14/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import DesignSystem

import ComposableArchitecture

public struct NetworkErrorView: View {
  @Environment(\.dismiss) var dismiss

  let store: StoreOf<NetworkErrorCore>

  public init(store: StoreOf<NetworkErrorCore>) {
    self.store = store
  }

  public var body: some View {
    HStack {
      Spacer()

      VStack(spacing: Alias.Spacing.xxxLarge) {
        Spacer()

        DesignSystemAsset.Image.noInternet.swiftUIImage

        VStack(spacing: Alias.Spacing.small) {
          Text("인터넷 연결이 불안정해요")
            .font(Typography.header4)
            .foregroundStyle(Alias.Color.Text.primary)
          Text("연결 상태를 확인한 후\n다시 시도해 주세요.")
            .multilineTextAlignment(.center)
            .font(Typography.bodyR)
            .foregroundStyle(Alias.Color.Text.secondary)
        }
        .padding(.bottom, 34)

        Button(title: "다시 시도하기") {
          store.send(.tryAgain)
          dismiss()
        }
        .buttonStyle(.box(level: .primary, size: .large, width: .medium))

        Spacer()
      }

      Spacer()
    }
    .background(Alias.Color.Background.primary)
  }
}
