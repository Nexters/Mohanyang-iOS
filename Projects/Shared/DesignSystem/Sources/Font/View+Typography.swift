//
//  View+Typography.swift
//  DesignSystem
//
//  Created by devMinseok on 8/10/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

extension View {
  public func font(_ typography: Typography) -> some View {
    return self
      .font(typography.font)
      .kerning(typography.letterSpacing)
      .lineSpacing(typography.lineHeight - typography.inherentLineHeight)
      .padding(.vertical, (typography.lineHeight - typography.inherentLineHeight) / 2)
  }
}
