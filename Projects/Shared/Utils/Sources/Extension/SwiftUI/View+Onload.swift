//
//  View+Extension.swift
//  Utils
//
//  Created by devMinseok on 8/16/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

extension View {
  public func onLoad(perform action: (() -> Void)? = nil) -> some View {
    modifier(ViewDidLoadModifier(perform: action))
  }
}

private struct ViewDidLoadModifier: ViewModifier {
  @State private var didLoad = false
  private let action: (() -> Void)?
  
  init(perform action: (() -> Void)? = nil) {
    self.action = action
  }
  
  func body(content: Content) -> some View {
    content.onAppear {
      if didLoad == false {
        didLoad = true
        action?()
      }
    }
  }
}
