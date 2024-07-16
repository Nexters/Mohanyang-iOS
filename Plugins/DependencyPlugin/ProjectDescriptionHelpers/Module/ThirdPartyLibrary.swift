//
//  ThirdPartyLibrary.swift
//  DependencyPlugin
//
//  Created by MinseokKang on 2024/07/15.
//

import ProjectDescription

/// 외부 라이브러리 모듈
@_spi(ThirdPartyLibrary)
public enum ThirdPartyLibrary: Modulable {
  case ThirdParty_TCA
  case ThirdParty_Kakao
  case ThirdParty_Realm
  case ThirdParty_Firebase
}


// MARK: - Path 정의

extension ThirdPartyLibrary {
  public var path: String {
    let typeName = String(describing: self)
    return "ThirdPartyLibrary/\(typeName)"
  }
}
