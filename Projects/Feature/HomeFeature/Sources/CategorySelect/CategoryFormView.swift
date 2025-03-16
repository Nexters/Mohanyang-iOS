//
//  CategoryFormView.swift
//  HomeFeature
//
//  Created by 김지현 on 2/24/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//

import SwiftUI

import DesignSystem

import ComposableArchitecture

public struct CategoryFormView: View {
  @Bindable var store: StoreOf<CategoryFormCore>

  public init(store: StoreOf<CategoryFormCore>) {
    self.store = store
  }

  public var body: some View {
    NavigationContainer(
      title: Text(store.formType.title),
      style: .navigation
    ) {
      VStack {
        Button {
          store.send(.editIconTapped)
        } label: {
          store.selectedIcon.image
            .padding(20)
            .background {
              RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(Alias.Color.Background.secondary)
            }
            .overlay(alignment: .bottomTrailing) {
              DesignSystemAsset.Image._20PenPrimary.swiftUIImage
                .renderingMode(.template)
                .foregroundStyle(Alias.Color.Icon.inverse)
                .padding(8)
                .background {
                  Circle().foregroundStyle(Alias.Color.Background.inverse)
                }
                .offset(x: 8)
            }
        }
        .padding(.top, 32)

        InputField(
          placeholder: store.formType == .add ? "카테고리 이름" : "",
          text: $store.text,
          fieldError: $store.inputFieldError,
          submitLabel: .done
        )
        .padding(.vertical, 24)

        Spacer(minLength: 0)

        Button("확인") {
          // add or edit
        }
        .buttonStyle(.box(level: .primary, size: .large, width: .low))
        .disabled(store.isButtonDisabled)
        .padding(.bottom, Alias.Spacing.small)
      }
    }
    .padding(.horizontal, Alias.Spacing.xLarge)
    .background(Global.Color.gray50)
    .bottomSheet(
      item: $store.scope(
        state: \.iconSelect,
        action: \.iconSelect
      )
    ) { store in
      CategoryIconSelectView(store: store)
    }
  }
}

