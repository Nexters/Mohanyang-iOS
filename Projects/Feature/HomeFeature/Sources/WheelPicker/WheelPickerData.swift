//
//  WheelPickerData.swift
//  HomeFeature
//
//  Created by devMinseok on 8/15/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

protocol WheelPickerData: Equatable, Identifiable {
  associatedtype Data: Equatable
  
  var title: String { get }
  var data: Data { get }
}
