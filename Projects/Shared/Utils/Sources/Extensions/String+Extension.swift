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
}
