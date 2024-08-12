//
//  RoundButtonStyle.swift
//  DesignSystem
//
//  Created by devMinseok on 8/12/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

public struct RoundButtonStyle: ButtonStyle {
  let level: RoundButtonStyleLevel
  
  public init(level: RoundButtonStyleLevel) {
    self.level = level
  }
  
  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .frame(width: 88, height: 88)
      .background(
        getBackgroundColor(isPressed: configuration.isPressed),
        in: RoundedRectangle(cornerRadius: 44)
      )
      .foregroundColor(Global.Color.white)
      .singleIconButtonDetailStyle(DefaultSingleIconButtonDetailStyle())
  }
  
  private func getBackgroundColor(isPressed: Bool) -> Color {
    if isPressed {
      return level.pressedBackground
    } else {
      return level.defaultBackground
    }
  }
}

extension ButtonStyle where Self == RoundButtonStyle {
  public static func round(
    level: RoundButtonStyleLevel
  ) -> Self {
    return RoundButtonStyle(level: level)
  }
}
