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
    Text("namingCat")
  }
}
