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
    VStack {
      Spacer()
      VStack {
        OnboardingCarouselView(data: $currentData)
        Button(title: "시작하기") {
          // go to selectCatView
        }
        .buttonStyle(.box(size: .large, color: .primary))
      }
      Spacer()
    }
  }
}

struct OnboardingCarouselView: View {
  @Binding var data: OnboardingItem

  var body: some View {
    VStack {
      ZStack {
        Rectangle()
          .foregroundStyle(Alias.Color.Background.secondary)
        data.image
      }
      Text(data.title)
      Text(data.subTitle)
    }


  }
}

struct OnboardingView_Previews: PreviewProvider {
  static var previews: some View {
    OnboardingView(store: Store(initialState: OnboardingCore.State()) { OnboardingCore() })
  }
}
