//
//  Typography.swift
//  DesignSystem
//
//  Created by devMinseok on 8/5/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

public enum Typography {
  case time
  case header1
  case header2
  case header3
  case header4
  case header5
  case bodySB
  case bodyR
  case subBodySB
  case subBodyR
  case captionSB
  case captionR
}

extension Typography {
  /// swiftui font
  var font: Font {
    return fontWeight.swiftUIFont(size: fontSize)
  }
  
  /// 폰트 line height
  var lineHeight: CGFloat {
    switch self {
    case .time:
      return 77
    case .header1:
      return 58
    case .header2:
      return 41
    case .header3:
      return 28
    case .header4:
      return 25
    case .header5:
      return 22
    case .bodySB:
      return 22
    case .bodyR:
      return 22
    case .subBodySB:
      return 21
    case .subBodyR:
      return 21
    case .captionSB:
      return 16
    case .captionR:
      return 16
    }
  }
  
  /// 폰트 고유 line height
  var inherentLineHeight: CGFloat {
    // swiftui의 Font는 고유 lineHeight를 못가져오기에 UIFont에서 가져옴
    return fontWeight.font(size: fontSize).lineHeight
  }
  
  /// 폰트 letter spacing
  var letterSpacing: CGFloat {
    switch self {
    case .time:
      return -1.28
    case .header1:
      return -0.96
    case .header2:
      return -0.68
    case .header3:
      return -0.48
    case .header4:
      return -0.4
    case .header5:
      return -0.36
    case .bodySB:
      return -0.32
    case .bodyR:
      return -0.32
    case .subBodySB:
      return -0.28
    case .subBodyR:
      return -0.28
    case .captionSB:
      return -0.12
    case .captionR:
      return -0.12
    }
  }
  
  /// 폰트 size
  private var fontSize: CGFloat {
    switch self {
    case .time:
      return 64
    case .header1:
      return 48
    case .header2:
      return 34
    case .header3:
      return 24
    case .header4:
      return 20
    case .header5:
      return 18
    case .bodySB:
      return 16
    case .bodyR:
      return 16
    case .subBodySB:
      return 14
    case .subBodyR:
      return 14
    case .captionSB:
      return 12
    case .captionR:
      return 12
    }
  }
  
  /// 폰트 weight
  private var fontWeight: DesignSystemFontConvertible {
    switch self {
    case .time:
      return DesignSystemFontFamily.Pretendard.bold
    case .header1:
      return DesignSystemFontFamily.Pretendard.bold
    case .header2:
      return DesignSystemFontFamily.Pretendard.bold
    case .header3:
      return DesignSystemFontFamily.Pretendard.bold
    case .header4:
      return DesignSystemFontFamily.Pretendard.semiBold
    case .header5:
      return DesignSystemFontFamily.Pretendard.semiBold
    case .bodySB:
      return DesignSystemFontFamily.Pretendard.semiBold
    case .bodyR:
      return DesignSystemFontFamily.Pretendard.regular
    case .subBodySB:
      return DesignSystemFontFamily.Pretendard.semiBold
    case .subBodyR:
      return DesignSystemFontFamily.Pretendard.regular
    case .captionSB:
      return DesignSystemFontFamily.Pretendard.semiBold
    case .captionR:
      return DesignSystemFontFamily.Pretendard.regular
    }
  }
}
