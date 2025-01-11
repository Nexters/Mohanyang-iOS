//
//  WheelPicker.swift
//  DesignSystem
//
//  Created by devMinseok on 8/13/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import DesignSystem
import Utils

struct WheelPicker<D: WheelPickerData>: View {
  @Namespace var backgroundFrameID
  @State var selectionID: D.ID?
  @Binding var selection: D?
  @State var backgroundRect: CGRect = .zero
  let sources: [D]
  let image: Image
  
  var itemHeight: CGFloat = 98
  var menuHeightMultiplier: CGFloat {
    return floor(backgroundRect.height / itemHeight)
  }
  var itemsCountAbove: Double {
    return Double(Int((menuHeightMultiplier - 1) / 2))
  }
  var pickerHeight: CGFloat {
    return itemHeight * (itemsCountAbove * 2 + 1)
  }
  var paddingAdjustment: CGFloat {
    return (Int(menuHeightMultiplier) % 2 == 0) ? itemHeight * 0.5 : 0
  }
  
  init(
    image: Image,
    sources: [D],
    selection: Binding<D?>
  ) {
    self.image = image
    self.sources = sources
    _selection = selection
  }
  
  var body: some View {
    ZStack(alignment: .center) {
      RoundedRectangle(cornerRadius: 16)
        .fill(Alias.Color.Background.secondary)
        .frame(width: 209, height: itemHeight)
        .overlay(alignment: .leading) {
          self.image
            .padding(.leading, 20)
        }
      ScrollViewReader { scrollViewProxy in
        ScrollView(.vertical) {
          LazyVStack(spacing: .zero) {
            Rectangle() // 상단 spacer
              .fill(Color.clear)
              .frame(height: itemHeight * itemsCountAbove)
            ForEach(sources) { item in
              GeometryReader { geometryProxy in
                let itemCenterY = geometryProxy.frame(in: .global).midY
                let viewCenterY = backgroundRect.midY
                let distance = abs(viewCenterY - itemCenterY)
                let scale = max(1, 1.4 - (distance / (itemHeight * 3)))
                
                Text(item.title)
                  .foregroundStyle(
                    item == selection ? Alias.Color.Text.primary : Alias.Color.Text.disabled
                  )
                  .font(Typography.header2)
                  .lineLimit(1)
                  .frame(height: itemHeight)
                  .scaleEffect(x: scale, y: scale, anchor: .leading)
                  .frame(maxWidth: .infinity)
              }
              .frame(height: itemHeight)
              .id(item.id)
            }
            Rectangle() // 하단 spacer
              .fill(Color.clear)
              .frame(height: itemHeight * itemsCountAbove)
          }
          .scrollTargetLayout(isEnabled: true)
        }
        .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
        .scrollPosition(id: $selectionID, anchor: .center)
        .scrollIndicators(.never)
        .frame(height: pickerHeight)
        .scrollClipDisabled()
        .padding(.vertical, paddingAdjustment)
        .clipShape(Rectangle())
        .onChange(of: selection) { _, value in
          guard let id = value?.id,
                selectionID != id
          else { return }
          scrollViewProxy.scrollTo(id, anchor: .center)
        }
      }
      
      LinearGradient(
        colors: [
          Alias.Color.Background.primary,
          .clear,
          Alias.Color.Background.primary
        ],
        startPoint: .top,
        endPoint: .bottom
      )
      .allowsHitTesting(false)
    }
    .setFrameMeasure(space: .global, identifier: backgroundFrameID)
    .getFrameMeasure { value in
      guard let frame = value[backgroundFrameID] else { return }
      backgroundRect = frame
    }
    .onChange(of: selectionID) { _, value in
      selection = sources.first { $0.id == value }
    }
  }
}
