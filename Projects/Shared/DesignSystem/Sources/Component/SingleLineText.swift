//
//  SingleLineText.swift
//  DesignSystem
//
//  Created by devMinseok on 12/17/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

public struct SingleLineText: View {
  let content: Text
  
  public init(@SingleLineTextBuilder content: () -> Text) {
    self.content = content()
  }
  
  public var body: some View {
    return content
  }
}

@resultBuilder
public enum SingleLineTextBuilder {
  public static func buildBlock(_ components: Text...) -> Text {
    return components.reduce(Text(""), { $0 + $1 })
  }
  
  public static func buildArray(_ components: [Text]) -> Text {
    return components.reduce(Text(""), { $0 + $1 })
  }
  
  public static func buildLimitedAvailability(_ component: Text) -> Text {
    return component
  }
  
  public static func buildEither(first component: Text) -> Text {
    return component
  }
  
  public static func buildEither(second component: Text) -> Text {
    return component
  }
  
  public static func buildExpression(_ expression: Text) -> Text {
    return expression
  }
  
  public static func buildOptional(_ component: Text?) -> Text {
    component ?? Text("")
  }
}
