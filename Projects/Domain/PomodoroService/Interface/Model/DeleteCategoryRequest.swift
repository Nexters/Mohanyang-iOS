//
//  DeleteCategoryRequest.swift
//  PomodoroServiceInterface
//
//  Created by 김지현 on 3/26/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//

import Foundation

public struct DeleteCategoryRequest: Encodable {
  let no: [Int]

  public init(no: [Int]) { self.no = no }
}
