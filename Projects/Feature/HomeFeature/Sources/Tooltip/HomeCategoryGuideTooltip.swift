//
//  HomeCategoryGuideTooltip.swift
//  HomeFeature
//
//  Created by devMinseok on 8/13/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import DesignSystem

public struct HomeCategoryGuideTooltip: Tooltip {
  public var title: Text { Text("눌러서 카테고리를 변경할 수 있어요") }
  
  public var color: TooltipColor { .white }
  
  public var direction: TooltipDirection { .down }
  
  public var dimEnabled: Bool { true }
  
  public var targetCornerRadius: CGFloat? { Alias.BorderRadius.xSmall }
  
  public var padding: CGFloat { 12 }
}

