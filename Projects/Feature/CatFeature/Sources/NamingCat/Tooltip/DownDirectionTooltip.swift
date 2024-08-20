//
//  DownDirectionTooltip.swift
//  OnboardingFeature
//
//  Created by devMinseok on 8/17/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import DesignSystem

public struct DownDirectionTooltip: Tooltip {
  public var title: Text { Text("반갑다냥! 내 이름을 지어줄래냥?") }
  public var color: TooltipColor { .white }
  public var direction: TooltipDirection { .down }
  public var targetCornerRadius: CGFloat? { Alias.BorderRadius.small }
  public var dimEnabled: Bool { false }
  public var padding: CGFloat { -20 }
}
