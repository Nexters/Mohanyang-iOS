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
import RiveRuntime

public struct NamingCatView: View {
  @Bindable var store: StoreOf<NamingCatCore>
  
  public init(store: StoreOf<NamingCatCore>) {
    self.store = store
  }
  
  public var body: some View {
    NavigationContainer(
      title: Text("고양이 이름짓기"),
      style: .navigation
    ) {
      VStack(spacing: 40) {
        Spacer()
        
        store.catRiv.view()
          .setTooltipTarget(tooltip: DownDirectionTooltip.self)
          .frame(maxHeight: 240)

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
        
        Button("확인") {
          store.send(.namedButtonTapped)
        }
        .buttonStyle(.box(level: .primary, size: .large, width: .low))
        .disabled(store.isButtonDisabled)
        .padding(.bottom, Alias.Spacing.small)
      }
      .padding(.horizontal, Alias.Spacing.xLarge)
    }
    .background {
      Alias.Color.Background.primary
        .ignoresSafeArea()
    }
    .tooltipDestination(tooltip: $store.tooltip.sending(\.setTooltip))
    .onAppear {
      store.send(.onAppear)
    }
  }
}
