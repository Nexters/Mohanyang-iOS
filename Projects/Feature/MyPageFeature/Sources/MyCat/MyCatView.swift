//
//  MyCatView.swift
//  MyPageFeature
//
//  Created by 김지현 on 8/19/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import CatFeature
import DesignSystem

import ComposableArchitecture

public struct MyCatView: View {
  @Bindable var store: StoreOf<MyCatCore>
  
  public init(store: StoreOf<MyCatCore>) {
    self.store = store
  }
  
  public var body: some View {
    Text("My Cat View")
  }
}
