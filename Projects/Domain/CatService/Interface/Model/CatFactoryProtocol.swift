//
//  CatFactoryProtocol.swift
//  OnboardingFeature
//
//  Created by 김지현 on 8/16/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

public protocol CatFactoryProtocol {
  var id: String { get } // catType의 rawValue
  var no: Int { get } // 서버에서 주는 no
  var name: String { get set } // 서버에서 주는 이름
  var keyword: String { get }
  var keywordImage: Image { get } // 키워드에 따른 아이콘 이미지
  var catImage: Image { get }
  var rivTriggerName: String { get }
  var rivInputName: String { get }
  var focusEndPushTitle: String { get }
  var restEndPushTitle: String { get }
  var disturbPushTitle: String { get }
}
