//
//  HomeCatDialogueTooltip.swift
//  HomeFeature
//
//  Created by devMinseok on 8/12/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import DesignSystem

public struct HomeCatDialogueTooltip: Tooltip {
  let _title: String
  
  public init(title: String) {
    _title = title
  }
  
  public var title: Text { Text(_title) }
  
  public var color: TooltipColor { .white }
  
  public var direction: TooltipDirection { .down }
  
  public var dimEnabled: Bool { false }
  
  public var targetCornerRadius: CGFloat? { nil }
  
  public var padding: CGFloat { -12 }
}
