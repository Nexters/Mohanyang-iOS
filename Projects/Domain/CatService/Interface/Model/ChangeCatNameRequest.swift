//
//  ChangeCatNameRequest.swift
//  CatServiceInterface
//
//  Created by devMinseok on 8/23/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

public struct ChangeCatNameRequest: Encodable {
  let name: String
  
  public init(name: String) {
    self.name = name
  }
}
