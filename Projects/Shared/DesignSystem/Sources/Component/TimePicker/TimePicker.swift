//
//  TimePicker.swift
//  DesignSystem
//
//  Created by devMinseok on 8/13/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

public struct TimeWheelPicker: View {
  @Binding var selectedIndex: Int?
  var items = Colors.allCases
  
  var itemHeight: CGFloat = 58.0
  var menuHeightMultiplier: CGFloat = 5
  
  public init(selectedIndex: Binding<Int?>) {
    _selectedIndex = selectedIndex
  }
  
  
  public var body: some View {
    let itemsCountAbove = Double(Int((menuHeightMultiplier - 1)/2))
    let degressMultiplier: Double = -40.0 / itemsCountAbove
    let scaleMultiplier: CGFloat = 0.1 / itemsCountAbove
    
    ZStack(alignment: .center) {
      RoundedRectangle(cornerRadius: 16)
        .fill(Alias.Color.Background.secondary)
        .frame(width: 200, height: itemHeight)
      
      ScrollView(.vertical) {
        LazyVStack(spacing: 0) {
          ForEach(0..<items.count, id:\.self) { index in
            let category = items[index]
            let indexDiff = Double(index-(selectedIndex ?? 0))
            HStack {
              Text(category.rawValue)
                .foregroundStyle(category.color)
                .padding()
                .frame(width: 100)
                .background(
                  RoundedRectangle(cornerRadius: 16)
                )
                .id(index)
            }
            .frame(height: itemHeight)
            .scaleEffect(x: 1 - CGFloat(abs(indexDiff) * scaleMultiplier))
            .animation(.smooth)
          }
        }
        .scrollTargetLayout()
        // so that first and last item can fit into the selction area
        .padding(.vertical, itemHeight * itemsCountAbove)
      }
      .scrollPosition(id: $selectedIndex, anchor: .center)
      .frame(height: itemHeight * (itemsCountAbove * 2 + 1))
      .frame(maxHeight: .infinity)
      //         adding padding if menuHeight multiplier is even number
      .padding(.vertical, (Int(menuHeightMultiplier) % 2 == 0) ? itemHeight * 0.5 : 0)
      // it has to be align top for the correct scroll position id
      .scrollTargetBehavior(.viewAligned)
      .scrollIndicators(.hidden)
    }
  }
}

public enum Colors: String, CaseIterable, Identifiable {
  case red
  case blue
  case orange
  case purple
  case green
  case gray
  case yellow
  case cyan
  case pink
  case mint
  
  public var id: Colors { self }
  
  public var color: Color {
    switch self {
    case .red:
      Color.red
    case .blue:
      Color.blue
    case .orange:
      Color.orange
    case .purple:
      Color.purple
    case .green:
      Color.green
    case .gray:
      Color.gray
    case .yellow:
        .yellow
    case .cyan:
        .cyan
    case .pink:
        .pink
    case .mint:
        .mint
    }
  }
}
