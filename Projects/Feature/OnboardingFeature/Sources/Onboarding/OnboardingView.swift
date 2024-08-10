//
//  OnboardingView.swift
//  OnboardingFeature
//
//  Created by 김지현 on 8/9/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI
import DesignSystem

import ComposableArchitecture

public struct OnboardingView: View {
  let store: StoreOf<OnboardingCore>
  @State var height: CGFloat = .zero
  @State var currentData: OnboardingItem = OnboardingItemsData[0]

  public init(store: StoreOf<OnboardingCore>) {
    self.store = store
  }

  public var body: some View {
    ZStack {
      Alias.Color.Background.primary
        .ignoresSafeArea()
      VStack {
        Spacer()
        VStack {
          OnboardingCarouselView(data: $currentData)
          Button(title: "시작하기") {
            // go to selectCatView
          }
          .buttonStyle(.box(size: .large, color: .primary))
        }
        .padding(.horizontal, 20)
        Spacer()
      }
    }
  }
}

struct OnboardingCarouselView: View {
  @Binding var data: OnboardingItem

  var body: some View {
    VStack(spacing: Alias.Spacing.xxxLarge) {
      ZStack {
        Rectangle()
          .foregroundStyle(Alias.Color.Background.secondary)
        data.image
      }
      .frame(width: 240, height: 240)

      VStack(spacing: Alias.Spacing.small) {
        Text(data.title)
          .font(Typography.header4)
          .foregroundStyle(Alias.Color.Text.primary)
        Text(data.subTitle)
          .font(Typography.bodyR)
          .foregroundStyle(Alias.Color.Text.secondary)
      }
      .multilineTextAlignment(.center)
    }
  }
}

struct OnboardingView_Previews: PreviewProvider {
  static var previews: some View {
    OnboardingView(store: Store(initialState: OnboardingCore.State()) { OnboardingCore() })
  }
}
