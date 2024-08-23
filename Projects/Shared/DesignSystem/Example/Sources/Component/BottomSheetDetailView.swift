//
//  BottomSheetDetailView.swift
//  DesignSystemExample
//
//  Created by devMinseok on 8/12/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import DesignSystem

enum BottomSheetColor: Identifiable {
  var id: Self { self }
  
  case red
  case green
  case blue
}

struct BottomSheetDetailView: View {
  @State var bottomSheet: BottomSheetColor?
  
  var body: some View {
    VStack(spacing: 10) {
      Spacer()
      Button {
        bottomSheet = .red
      } label: {
        Text("red bottom sheet")
      }
      Button {
        bottomSheet = .green
      } label: {
        Text("green bottom sheet")
      }
      Button {
        bottomSheet = .blue
      } label: {
        Text("blue bottom sheet")
      }
      Spacer()
    }
    .bottomSheet(item: $bottomSheet) { item in
      BottomSheetChildView(color: item)
    }
  }
}

#Preview {
  BottomSheetDetailView()
}

struct BottomSheetChildView: View {
  let color: BottomSheetColor
  
  var body: some View {
    ScrollView {
      VStack {
        switch color {
        case .red:
          Color.red
            .frame(height: 400)
        case .green:
          Color.green
            .frame(height: 400)
        case .blue:
          Color.blue
            .frame(height: 400)
        }
      }
    }
  }
}
