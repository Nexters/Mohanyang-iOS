//
//  BarButtonDetail.swift
//  DesignSystem
//
//  Created by devMinseok on 8/7/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

extension Button {
  public init(
    title: LocalizedStringKey,
    action: @escaping () -> Void
  ) where Label == BarButtonDetail<Text, EmptyView?, EmptyView?> {
    self.init(action: action) {
      BarButtonDetail {
        Text(title)
      } leftIcon: {
        nil as EmptyView?
      } rightIcon: {
        nil as EmptyView?
      }
    }
  }

  public init<LeftIcon: View, RightIcon: View>(
    title: LocalizedStringKey,
    @ViewBuilder leftIcon: () -> LeftIcon?,
    @ViewBuilder rightIcon: () -> RightIcon?,
    action: @escaping () -> Void
  ) where Label == BarButtonDetail<Text, LeftIcon?, RightIcon?> {
    self.init(action: action) {
      BarButtonDetail {
        Text(title)
      } leftIcon: {
        leftIcon()
      } rightIcon: {
        rightIcon()
      }
    }
  }

  public init<LeftIcon: View>(
    title: LocalizedStringKey,
    @ViewBuilder leftIcon: () -> LeftIcon?,
    action: @escaping () -> Void
  ) where Label == BarButtonDetail<Text, LeftIcon?, EmptyView?> {
    self.init(action: action) {
      BarButtonDetail {
        Text(title)
      } leftIcon: {
        leftIcon()
      } rightIcon: {
        nil as EmptyView?
      }
    }
  }

  public init<RightIcon: View>(
    title: LocalizedStringKey,
    @ViewBuilder rightIcon: () -> RightIcon?,
    action: @escaping () -> Void
  ) where Label == BarButtonDetail<Text, EmptyView?, RightIcon?> {
    self.init(action: action) {
      BarButtonDetail {
        Text(title)
      } leftIcon: {
        nil as EmptyView?
      } rightIcon: {
        rightIcon()
      }
    }
  }
}

public struct BarButtonDetail<Title: View, LeftIcon: View, RightIcon: View>: View {
  @Environment(\.barButtonDetailStyle) private var style
  private let title: Title
  private let leftIcon: LeftIcon
  private let rightIcon: RightIcon
  
  init(
    @ViewBuilder title: () -> Title,
    @ViewBuilder leftIcon: () -> LeftIcon,
    @ViewBuilder rightIcon: () -> RightIcon
  ) {
    self.title = title()
    self.leftIcon = leftIcon()
    self.rightIcon = rightIcon()
  }
  
  public var body: some View {
    let configuration = BarButtonDetailConfiguration(
      title: title,
      leftIcon: leftIcon,
      rightIcon: rightIcon
    )
    AnyView(style.resolve(configuration: configuration))
  }
}

struct BarButtonDetailConfiguration {
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

protocol BarButtonDetailStyle: DynamicProperty {
  typealias Configuration = BarButtonDetailConfiguration
  associatedtype Body: View
  
  @ViewBuilder func makeBody(configuration: Configuration) -> Body
}

extension BarButtonDetailStyle {
  fileprivate func resolve(configuration: Configuration) -> some View {
    ResolvedDetailStyle(style: self, configuration: configuration)
  }
}

private struct ResolvedDetailStyle<Style: BarButtonDetailStyle>: View {
  let style: Style
  let configuration: Style.Configuration
  
  var body: some View {
    style.makeBody(configuration: configuration)
  }
}

struct BarButtonDetailStyleKey: EnvironmentKey {
  static var defaultValue: any BarButtonDetailStyle = DefaultBarButtonDetailStyle()
}

extension EnvironmentValues {
  fileprivate var barButtonDetailStyle: any BarButtonDetailStyle {
    get { self[BarButtonDetailStyleKey.self] }
    set { self[BarButtonDetailStyleKey.self] = newValue }
  }
}

extension View {
  func barButtonDetailStyle(_ style: some BarButtonDetailStyle) -> some View {
    environment(\.barButtonDetailStyle, style)
  }
}

struct DefaultBarButtonDetailStyle: BarButtonDetailStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack(spacing: Alias.Spacing.small) {
      configuration.leftIcon
        .frame(width: 24, height: 24)
      configuration.title
      configuration.rightIcon
        .frame(width: 24, height: 24)
    }
  }
}
