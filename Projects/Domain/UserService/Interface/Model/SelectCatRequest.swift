//
//  SelectCatRequest.swift
//  UserServiceInterface
//
//  Created by devMinseok on 8/22/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

public struct SelectCatRequest: Encodable {
  let catNo: Int
  
  public init(catNo: Int) {
    self.catNo = catNo
  }
}
