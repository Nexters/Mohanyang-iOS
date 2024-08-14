//
//  TimeWheelPickerDetailView.swift
//  DesignSystemExample
//
//  Created by devMinseok on 8/13/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import DesignSystem

struct TimeWheelPickerDetailView: View {
  @State var selectedIndex: Int? = 3
  let items = Colors.allCases
  
  var body: some View {
    NavigationContainer(
      style: .modal
    ) {
      VStack {
        Button(
          title: "작업",
          leftIcon: DesignSystemAsset.Image._24WorkPrimary.swiftUIImage,
          action: {}
        )
        .buttonStyle(.text(level: .primary, size: .medium))
        
        TimeWheelPicker(selectedIndex: $selectedIndex)
        
        Button(
          icon: DesignSystemAsset.Image._32PlayPrimary.swiftUIImage,
          action: {
            
          }
        )
        .buttonStyle(.round(level: .secondary))
        .padding(.vertical, 40)
      }
    }
  }
}

#Preview {
  TimeWheelPickerDetailView()
}
