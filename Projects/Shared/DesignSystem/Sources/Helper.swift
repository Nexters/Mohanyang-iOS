//
//  Helper.swift
//  DesignSystem
//
//  Created by devMinseok on 8/7/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

extension Button where Label == Detail<Text, Image?, Image?> {
  public init(
    title: LocalizedStringKey,
    leftIcon: Image? = nil,
    rightIcon: Image? = nil,
    action: @escaping () -> Void
  ) {
    self.init(action: action) {
      Detail {
        Text(title)
      } leftIcon: {
        leftIcon
      } rightIcon: {
        rightIcon
      }
    }
  }
}

public struct Detail<Title: View, LeftIcon: View, RightIcon: View>: View {
  @Environment(\.detailStyle) private var style
  private let title: Title
  private let leftIcon: LeftIcon
  private let rightIcon: RightIcon
  
  init (
    @ViewBuilder title: () -> Title,
    @ViewBuilder leftIcon: () -> LeftIcon,
    @ViewBuilder rightIcon: () -> RightIcon
  ) {
    self.title = title()
    self.leftIcon = leftIcon()
    self.rightIcon = rightIcon()
  }
  
  public var body: some View {
    let configuration = DetailStyleConfiguration(
      title: title,
      leftIcon: leftIcon,
      rightIcon: rightIcon
    )
    AnyView(style.resolve(configuration: configuration))
  }
}

struct DetailStyleConfiguration {
  struct Title: View {
    let body: AnyView
  }
  
  struct LeftIcon: View {
    let body: AnyView
  }
  
  struct RightIcon: View {
    let body: AnyView
  }
  
  let title: Title
  let leftIcon: LeftIcon
  let rightIcon: RightIcon
  
  fileprivate init(title: some View, leftIcon: some View, rightIcon: some View) {
    self.title = Title(body: AnyView(title))
    self.leftIcon = LeftIcon(body: AnyView(leftIcon))
    self.rightIcon = RightIcon(body: AnyView(rightIcon))
  }
}

protocol DetailStyle: DynamicProperty {
  typealias Configuration = DetailStyleConfiguration
  associatedtype Body : View
  
  @ViewBuilder func makeBody(configuration: Configuration) -> Body
}

extension DetailStyle {
  fileprivate func resolve(configuration: Configuration) -> some View {
    ResolvedDetailStyle(style: self, configuration: configuration)
  }
}

private struct ResolvedDetailStyle<Style: DetailStyle>: View {
  let style: Style
  let configuration: Style.Configuration
  
  var body: some View {
    style.makeBody(configuration: configuration)
  }
}

struct DetailStyleKey: EnvironmentKey {
  static var defaultValue: any DetailStyle = BoxButtonDetailStyle()
}

extension EnvironmentValues {
  fileprivate var detailStyle : any DetailStyle {
    get { self[DetailStyleKey.self] }
    set { self[DetailStyleKey.self] = newValue }
  }
}

extension View {
  func detailStyle(_ style: some DetailStyle) -> some View {
    environment(\.detailStyle, style)
  }
}
