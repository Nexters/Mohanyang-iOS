//
//  SelectButtonDetail.swift
//  DesignSystem
//
//  Created by devMinseok on 8/13/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

extension Button where Label == SelectButtonDetail<Text?, Text?, Image?, Image?> {
  public init(
    title: LocalizedStringKey? = nil,
    subtitle: LocalizedStringKey? = nil,
    leftIcon: Image? = nil,
    rightIcon: Image? = nil,
    action: @escaping () -> Void
  ) {
    self.init(action: action) {
      SelectButtonDetail {
        title == nil ? nil : Text(title ?? "")
      } subtitle: {
        title == nil ? nil : Text(subtitle ?? "")
      } leftIcon: {
        leftIcon
      } rightIcon: {
        rightIcon
      }
    }
  }
}

public struct SelectButtonDetail<Title: View, Subtitle: View, LeftIcon: View, RightIcon: View>: View {
  @Environment(\.selectButtonDetailStyle) private var style
  private let title: Title
  private let subtitle: Subtitle
  private let leftIcon: LeftIcon
  private let rightIcon: RightIcon
  
  init(
    @ViewBuilder title: () -> Title,
    @ViewBuilder subtitle: () -> Subtitle,
    @ViewBuilder leftIcon: () -> LeftIcon,
    @ViewBuilder rightIcon: () -> RightIcon
  ) {
    self.title = title()
    self.subtitle = subtitle()
    self.leftIcon = leftIcon()
    self.rightIcon = rightIcon()
  }
  
  public var body: some View {
    let configuration = SelectButtonDetailConfiguration(
      title: title,
      subtitle: subtitle,
      leftIcon: leftIcon,
      rightIcon: rightIcon
    )
    AnyView(style.resolve(configuration: configuration))
  }
}

struct SelectButtonDetailConfiguration {
  struct Title: View {
    let body: AnyView
  }
  
  struct Subtitle: View {
    let body: AnyView
  }
  
  struct LeftIcon: View {
    let body: AnyView
  }
  
  struct RightIcon: View {
    let body: AnyView
  }
  
  let title: Title
  let subtitle: Subtitle
  let leftIcon: LeftIcon
  let rightIcon: RightIcon
  
  fileprivate init(
    title: some View,
    subtitle: some View,
    leftIcon: some View,
    rightIcon: some View
  ) {
    self.title = Title(body: AnyView(title))
    self.subtitle = Subtitle(body: AnyView(subtitle))
    self.leftIcon = LeftIcon(body: AnyView(leftIcon))
    self.rightIcon = RightIcon(body: AnyView(rightIcon))
  }
}

protocol SelectButtonDetailStyle: DynamicProperty {
  typealias Configuration = SelectButtonDetailConfiguration
  associatedtype Body: View
  
  @ViewBuilder func makeBody(configuration: Configuration) -> Body
}

extension SelectButtonDetailStyle {
  fileprivate func resolve(configuration: Configuration) -> some View {
    SelectButtonResolvedDetailStyle(style: self, configuration: configuration)
  }
}

private struct SelectButtonResolvedDetailStyle<Style: SelectButtonDetailStyle>: View {
  let style: Style
  let configuration: Style.Configuration
  
  var body: some View {
    style.makeBody(configuration: configuration)
  }
}

struct SelectButtonDetailStyleKey: EnvironmentKey {
  static var defaultValue: any SelectButtonDetailStyle = DefaultSelectButtonDetailStyle()
}

extension EnvironmentValues {
  fileprivate var selectButtonDetailStyle: any SelectButtonDetailStyle {
    get { self[SelectButtonDetailStyleKey.self] }
    set { self[SelectButtonDetailStyleKey.self] = newValue }
  }
}

extension View {
  func selectButtonDetailStyle(_ style: some SelectButtonDetailStyle) -> some View {
    environment(\.selectButtonDetailStyle, style)
  }
}

struct DefaultSelectButtonDetailStyle: SelectButtonDetailStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack {
      configuration.title
      configuration.subtitle
      configuration.leftIcon
      configuration.rightIcon
    }
  }
}
