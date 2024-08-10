//
//  TooltipDetailView.swift
//  DesignSystemExample
//
//  Created by devMinseok on 8/7/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import DesignSystem

struct TooltipDetailView: View {
  @State var downDirectionTooltip: DownDirectionTooltip?
  @State var upDirectionTooltip: UpDirectionTooltip?
  @State var downDirectionWithDimTooltip: DownDirectionWithDimTooltip?
  @State var upDirectionWithDimTooltip: UpDirectionWithDimTooltip?
  
  let downDirectionTooltip_ = DownDirectionTooltip()
  let upDirectionTooltip_ = UpDirectionTooltip()
  let downDirectionWithDimTooltip_ = DownDirectionWithDimTooltip()
  let upDirectionWithDimTooltip_ = UpDirectionWithDimTooltip()
  
  
  var body: some View {
    VStack {
      Button(
        title: "Direction: .down, Color: .white, dim: false",
        action: {
          downDirectionTooltip = downDirectionTooltip_
        }
      )
      .buttonStyle(.box(size: .large, color: .primary))
      .setTooltipTarget(tooltip: downDirectionTooltip_)
      
      Button(
        title: "Direction: .up, Color: .black, dim: false",
        action: {
          upDirectionTooltip = upDirectionTooltip_
        }
      )
      .buttonStyle(.box(size: .large, color: .primary))
      .setTooltipTarget(tooltip: upDirectionTooltip_)
      
      Button(
        title: "Direction: .down, Color: .white, dim: true",
        action: {
          downDirectionWithDimTooltip = downDirectionWithDimTooltip_
        }
      )
      .buttonStyle(.box(size: .large, color: .primary))
      .setTooltipTarget(tooltip: downDirectionWithDimTooltip_)
      
      Button(
        title: "Direction: .up, Color: .black, dim: true",
        action: {
          upDirectionWithDimTooltip = upDirectionWithDimTooltip_
        }
      )
      .buttonStyle(.box(size: .large, color: .primary))
      .setTooltipTarget(tooltip: upDirectionWithDimTooltip_)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.yellow)
    .tooltipDestination(tooltip: $downDirectionTooltip)
    .tooltipDestination(tooltip: $upDirectionTooltip)
    .tooltipDestination(tooltip: $downDirectionWithDimTooltip)
    .tooltipDestination(tooltip: $upDirectionWithDimTooltip)
  }
}



struct DownDirectionTooltip: Tooltip {
  var title: Text { Text("DownDirectionTooltip") }
  var color: TooltipColor { .white }
  var direction: TooltipDirection { .down }
  var targetCornerRadius: CGFloat? { Alias.BorderRadius.small }
  var dimEnabled: Bool { false }
  var padding: CGFloat { 12 }
}

struct UpDirectionTooltip: Tooltip {
  var title: Text { Text("UpDirectionTooltip") }
  var color: TooltipColor { .black }
  var direction: TooltipDirection { .up }
  var targetCornerRadius: CGFloat? { Alias.BorderRadius.small }
  var dimEnabled: Bool { false }
  var padding: CGFloat { 12 }
}

struct DownDirectionWithDimTooltip: Tooltip {
  var title: Text { Text("DownDirectionWithDimTooltip") }
  var color: TooltipColor { .white }
  var direction: TooltipDirection { .down }
  var targetCornerRadius: CGFloat? { Alias.BorderRadius.small }
  var dimEnabled: Bool { true }
  var padding: CGFloat { 12 }
}

struct UpDirectionWithDimTooltip: Tooltip {
  var title: Text { Text("UpDirectionWithDimTooltip") }
  var color: TooltipColor { .black }
  var direction: TooltipDirection { .up }
  var targetCornerRadius: CGFloat? { Alias.BorderRadius.small }
  var dimEnabled: Bool { true }
  var padding: CGFloat { 12 }
}


// Preview환경에서만 크래시 발생:
// some View와 같은 제너릭 타입은 프리뷰에서 타입 추론에 문제가 생길 수 있습니다. 특히 프리뷰의 경우, 다양한 뷰가 서로 다른 타입으로 처리될 수 있어, 뷰의 타입이 명확하지 않은 경우 문제가 발생할 수 있습니다.
//#Preview {
//  TooltipDetailView()
//}
