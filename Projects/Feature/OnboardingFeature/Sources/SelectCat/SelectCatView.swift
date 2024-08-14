//
//  SelectCatView.swift
//  OnboardingFeature
//
//  Created by 김지현 on 8/14/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import DesignSystem

import ComposableArchitecture

public struct SelectCatView: View {
  @Bindable var store: StoreOf<SelectCatCore>
  
  public init(store: StoreOf<SelectCatCore>) {
    self.store = store
  }
  
  public var body: some View {
    NavigationContainer(
      title: Text("고양이 선택"),
      style: .navigation,
      navBackground: .clear
    ) {
      Text("SELECT CAT VIEW")
    }
    .background {
      Alias.Color.Background.primary
        .ignoresSafeArea()
    }
  }
}
