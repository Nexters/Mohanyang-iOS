//
//  SingleIconButtonDetail.swift
//  DesignSystem
//
//  Created by devMinseok on 8/12/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

extension Button where Label == SingleIconButtonDetail<Image> {
  public init(
    icon: Image,
    action: @escaping () -> Void
  ) {
    self.init(action: action) {
      SingleIconButtonDetail {
        icon.renderingMode(.template)
      }
    }
  }
}

public struct SingleIconButtonDetail<Icon: View>: View {
  @Environment(\.singleIconButtonDetailStyle) private var style
  private let icon: Icon
  
  init(
    @ViewBuilder icon: () -> Icon
  ) {
    self.icon = icon()
  }
  
  public var body: some View {
    let configuration = SingleIconButtonDetailConfiguration(icon: icon)
    AnyView(style.resolve(configuration: configuration))
  }
}

struct SingleIconButtonDetailConfiguration {
  struct Icon: View {
    let body: AnyView
  }
  
  let icon: Icon
  
  fileprivate init(icon: some View) {
    self.icon = Icon(body: AnyView(icon))
  }
}

protocol SingleIconButtonDetailStyle: DynamicProperty {
  typealias Configuration = SingleIconButtonDetailConfiguration
  associatedtype Body: View
  
  @ViewBuilder func makeBody(configuration: Configuration) -> Body
}

extension SingleIconButtonDetailStyle {
  fileprivate func resolve(configuration: Configuration) -> some View {
    SingleIconButtonResolvedDetailStyle(style: self, configuration: configuration)
  }
}

private struct SingleIconButtonResolvedDetailStyle<Style: SingleIconButtonDetailStyle>: View {
  let style: Style
  let configuration: Style.Configuration
  
  var body: some View {
    style.makeBody(configuration: configuration)
  }
}

struct SingleIconButtonDetailStyleKey: EnvironmentKey {
  static var defaultValue: any SingleIconButtonDetailStyle = DefaultSingleIconButtonDetailStyle()
}

extension EnvironmentValues {
  fileprivate var singleIconButtonDetailStyle: any SingleIconButtonDetailStyle {
    get { self[SingleIconButtonDetailStyleKey.self] }
    set { self[SingleIconButtonDetailStyleKey.self] = newValue }
  }
}

extension View {
  func singleIconButtonDetailStyle(_ style: some SingleIconButtonDetailStyle) -> some View {
    environment(\.singleIconButtonDetailStyle, style)
  }
}

struct DefaultSingleIconButtonDetailStyle: SingleIconButtonDetailStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.icon
  }
}
