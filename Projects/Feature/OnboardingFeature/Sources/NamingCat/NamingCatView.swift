//
//  NamingCatView.swift
//  OnboardingFeature
//
//  Created by 김지현 on 8/17/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import DesignSystem

import ComposableArchitecture

struct NamingCatView: View {
  @Bindable var store: StoreOf<NamingCatCore>
  
  init(store: StoreOf<NamingCatCore>) {
    self.store = store
  }
  
  var body: some View {
    NavigationContainer(
      title: Text("고양이 이름짓기"),
      style: .navigation
    ) {
      VStack(spacing: 40) {
        Spacer()

        ZStack {
          Rectangle()
            .foregroundStyle(Alias.Color.Background.secondary)
            .frame(height: 240)
          store.selectedCat.catImage
            .setTooltipTarget(tooltip: DownDirectionTooltip.self)
        }

        VStack(spacing: Alias.Spacing.small) {
          HStack {
            Text("내 고양이의 이름")
              .font(Typography.subBodyR)
              .foregroundStyle(Alias.Color.Text.secondary)
              .padding(.leading, Alias.Spacing.xSmall)
            Spacer()
          }
          InputField(
            placeholder: store.selectedCat.name,
            text: $store.text,
            fieldError: $store.inputFieldError
          )
        }

        Spacer()

        Button(title: "시작하기") {
          store.send(.tapStartButton)
        }
        .buttonStyle(.box(level: .primary, size: .large, width: .low))
        .disabled(store.inputFieldError != nil || store.text == "")
      }
      .padding(.horizontal, 20)
    }
    .background {
      Alias.Color.Background.primary
        .ignoresSafeArea()
    }
    .tooltipDestination(tooltip: $store.tooltip.sending(\.setTooltip))
  }
}
