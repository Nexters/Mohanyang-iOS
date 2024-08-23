//
//  MyCatTooltip.swift
//  MyPageFeature
//
//  Created by 김지현 on 8/19/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import DesignSystem

public struct MyCatTooltip: Tooltip {
  public var title: Text { Text("사냥놀이를 하고싶다냥") }
  public var color: TooltipColor { .white }
  public var direction: TooltipDirection { .down }
  public var targetCornerRadius: CGFloat? { Alias.BorderRadius.small }
  public var dimEnabled: Bool { false }
  public var padding: CGFloat { 12 }
}
