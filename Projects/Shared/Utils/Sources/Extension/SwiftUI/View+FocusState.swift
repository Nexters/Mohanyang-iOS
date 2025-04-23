//
//  View+FocusState.swift
//  Utils
//
//  Created by devMinseok on 4/21/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//

import SwiftUI

extension View {
  /// FocusState <-> reducer synchronize
  public func synchronize<Value: Equatable>(
    _ first: Binding<Value>,
    _ second: FocusState<Value>.Binding
  ) -> some View {
    self
      .onChange(of: first.wrappedValue) { _, newValue in
        second.wrappedValue = newValue
      }
      .onChange(of: second.wrappedValue) { _, newValue in
        first.wrappedValue = newValue
      }
  }
}
