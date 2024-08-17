//
//  String+.swift
//  Utils
//
//  Created by 김지현 on 8/16/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

extension String {
  public func camelCased() -> String {
    let components = self.lowercased().split(separator: "_")
    let camelCased = components
      .enumerated()
      .map { index, component in
        index == 0 ? String(component) : component.capitalized
      }
      .joined()
    return camelCased
  }

  public func containsWhitespaceOrSpecialCharacters() -> Bool {
    let pattern = "[^a-zA-Z0-9가-힣ㄱ-ㅎㅏ-ㅣ]"
    let regex = try! NSRegularExpression(pattern: pattern)
    let range = NSRange(location: 0, length: self.utf16.count)
    return regex.firstMatch(in: self, options: [], range: range) != nil
  }
}
