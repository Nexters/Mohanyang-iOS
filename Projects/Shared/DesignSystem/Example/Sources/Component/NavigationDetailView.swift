//
//  NavigationDetailView.swift
//  DesignSystemExample
//
//  Created by devMinseok on 8/7/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import DesignSystem

struct NavigationDetailView: View {
  var body: some View {
    NavigationContainer(
      title: Text("Title"),
      style: .navigation,
      navBackground: .clear
    ) {
      ScrollView {
        
      }
    }
    .background(Global.Color.gray50)
  }
}

#Preview {
  NavigationDetailView()
}
