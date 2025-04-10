//
//  View+Keyboard.swift
//  Utils
//
//  Created by 김지현 on 4/10/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//

import SwiftUI

public extension View {
  func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}
