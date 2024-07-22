//
//  OnboardingView.swift
//  OnboardingFeatureInterface
//
//  Created by devMinseok on 7/22/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

public struct OnboardingView: View {
  let store: StoreOf<OnboardingCore>
  
  public init(store: StoreOf<OnboardingCore>) {
    self.store = store
  }
  
  public var body: some View {
    VStack {
      Text("Onboarding")
        .foregroundStyle(Color.black)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.white)
  }
}
