//
//  Date+Extension.swift
//  Utils
//
//  Created by devMinseok on 7/31/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//

import Foundation

extension Date {
  /// format 형식의 string으로 변환
  public func toString(format: DateFormatType) -> String {
    let dateFormatter = DateFormatter()
    if format.isLocalizationRequired {
      dateFormatter.setLocalizedDateFormatFromTemplate(format.rawValue)
    } else {
      dateFormatter.dateFormat = format.rawValue
    }
    return dateFormatter.string(from: self)
  }
}

public enum DateFormatType: String {
  /// ex) 00:00
  case HH_mm = "HH:mm"
  /// 1월 1일
  case 월일 = "MMM dd"
  ///
  case 시분초 = "HH mm ss"
  ///
  case 분초 = "mm ss"
  ///
  case yyyy_MM_dd = "yyyy-MM-dd"
  ///
  case Md = "M/d"


  /// 현지화가 필요한 format
  var isLocalizationRequired: Bool {
    switch self {
    case .월일, .시분초, .분초:
      return true
    default:
      return false
    }
  }
}
