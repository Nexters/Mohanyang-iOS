//
//  CategorySelectView.swift
//  HomeFeature
//
//  Created by devMinseok on 8/13/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import DesignSystem

import ComposableArchitecture

public struct CategorySelectView: View {
  @Bindable var store: StoreOf<CategorySelectCore>
  
  public init(store: StoreOf<CategorySelectCore>) {
    self.store = store
  }
  
  public var body: some View {
    VStack(spacing: Alias.Spacing.large) {
      HStack(spacing: .zero) {
        Text("카테고리 변경")
          .font(Typography.header3)
          .foregroundStyle(Alias.Color.Text.primary)
        Spacer()
        Button(
          icon: DesignSystemAsset.Image._24CancelPrimary.swiftUIImage,
          action: {
            store.send(.dismissButtonTapped)
          }
        )
        .buttonStyle(.icon(isFilled: false, level: .primary))
      }
      .padding(.leading, Alias.Spacing.xLarge)
      .padding(.trailing, Alias.Spacing.small)
      .frame(height: 40)
      
      VStack(spacing: Alias.Spacing.small) {
        // TODO: - list select button 배치
      }
      .padding(.horizontal, Alias.Spacing.large)
      
      Button(
        title: "확인",
        action: {
          store.send(.bottomCheckButtonTapped)
        }
      )
      .buttonStyle(.box(level: .secondary, size: .large, width: .low))
      .padding(.horizontal, Alias.Spacing.large)
      .padding(.bottom, Alias.Spacing.medium)
    }
    .onAppear {
      store.send(.onAppear)
    }
  }
}
