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
import DatadogRUM

public struct NamingCatView: View {
  @Namespace var backgroundFrameID
  @Bindable var store: StoreOf<NamingCatCore>
  
  public init(store: StoreOf<NamingCatCore>) {
    self.store = store
  }

  public var body: some View {
    NavigationContainer(
      title: Text("고양이 이름짓기"),
      style: .navigation
    ) {
      ScrollView {
        VStack(spacing: Alias.Spacing.xLarge) {
          Spacer(minLength: 0)

          store.catRiv.view()
            .setTooltipTarget(tooltip: DownDirectionTooltip.self)
            .frame(minHeight: 200, maxHeight: 240)

          VStack(spacing: Alias.Spacing.small) {
            HStack {
              Text("내 고양이의 이름")
                .font(Typography.subBodyR)
                .foregroundStyle(Alias.Color.Text.secondary)
                .padding(.leading, Alias.Spacing.xSmall)
              Spacer()
            }
            InputField(
              placeholder: store.selectedCat?.defaultName ?? "",
              text: $store.text,
              fieldError: $store.inputFieldError,
              submitLabel: .done
            )
          }

          Spacer(minLength: 0)

          Button("확인") {
            store.send(.namedButtonTapped)
          }
          .buttonStyle(.box(level: .primary, size: .large, width: .low))
          .disabled(store.isButtonDisabled)
          .padding(.bottom, Alias.Spacing.small)
        }
        .padding(.horizontal, Alias.Spacing.xLarge)
        .frame(minHeight: store.height - 56)
      }
    }
    .scrollDismissesKeyboard(.interactively)
    .tooltipDestination(tooltip: $store.tooltip.sending(\.setTooltip))
    .background {
      Alias.Color.Background.primary
        .ignoresSafeArea()
    }
    .setFrameMeasure(space: .local, identifier: backgroundFrameID)
    .getFrameMeasure { value in
      guard let frame = value[backgroundFrameID] else { return }
      store.height = frame.height
    }
    .onAppear {
      store.send(.onAppear)
    }
    .trackRUMView(name: "고양이 이름짓기")
  }
}
