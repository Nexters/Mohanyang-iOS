//
//  ColorTokens.swift
//  DesignSystem
//
//  Created by devMinseok on 8/5/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

public enum Global {
  public enum Color {
    public static let white = DesignSystemAsset.Color.white.swiftUIColor
    public static let black = DesignSystemAsset.Color.black.swiftUIColor
    
    public static let gray50 = DesignSystemAsset.Color.gray50.swiftUIColor
    public static let gray100 = DesignSystemAsset.Color.gray100.swiftUIColor
    public static let gray200 = DesignSystemAsset.Color.gray200.swiftUIColor
    public static let gray300 = DesignSystemAsset.Color.gray300.swiftUIColor
    public static let gray400 = DesignSystemAsset.Color.gray400.swiftUIColor
    public static let gray500 = DesignSystemAsset.Color.gray500.swiftUIColor
    public static let gray600 = DesignSystemAsset.Color.gray600.swiftUIColor
    public static let gray700 = DesignSystemAsset.Color.gray700.swiftUIColor
    public static let gray800 = DesignSystemAsset.Color.gray800.swiftUIColor
    public static let gray900 = DesignSystemAsset.Color.gray900.swiftUIColor
    
    public static let orange50 = DesignSystemAsset.Color.orange50.swiftUIColor
    public static let orange100 = DesignSystemAsset.Color.orange100.swiftUIColor
    public static let orange200 = DesignSystemAsset.Color.orange200.swiftUIColor
    public static let orange300 = DesignSystemAsset.Color.orange300.swiftUIColor
    public static let orange400 = DesignSystemAsset.Color.orange400.swiftUIColor
    public static let orange500 = DesignSystemAsset.Color.orange500.swiftUIColor
    public static let orange600 = DesignSystemAsset.Color.orange600.swiftUIColor
    public static let orange700 = DesignSystemAsset.Color.orange700.swiftUIColor
    public static let orange800 = DesignSystemAsset.Color.orange800.swiftUIColor
    public static let orange900 = DesignSystemAsset.Color.orange900.swiftUIColor

    public static let yellow100 = DesignSystemAsset.Color.yellow100.swiftUIColor

    public static let red50 = DesignSystemAsset.Color.red50.swiftUIColor
    public static let red100 = DesignSystemAsset.Color.red100.swiftUIColor
    public static let red200 = DesignSystemAsset.Color.red200.swiftUIColor
    public static let red300 = DesignSystemAsset.Color.red300.swiftUIColor
    public static let red400 = DesignSystemAsset.Color.red400.swiftUIColor
    public static let red500 = DesignSystemAsset.Color.red500.swiftUIColor
    public static let red600 = DesignSystemAsset.Color.red600.swiftUIColor
    public static let red700 = DesignSystemAsset.Color.red700.swiftUIColor
    public static let red800 = DesignSystemAsset.Color.red800.swiftUIColor
    public static let red900 = DesignSystemAsset.Color.red900.swiftUIColor
  }
  
  public enum Dimension {
    public static let _2f: CGFloat = 2
    public static let _4f: CGFloat = 4
    public static let _8f: CGFloat = 8
    public static let _12f: CGFloat = 12
    public static let _16f: CGFloat = 16
    public static let _20f: CGFloat = 20
    public static let _24f: CGFloat = 24
    public static let _28f: CGFloat = 28
    public static let _32f: CGFloat = 32
    public static let _48f: CGFloat = 48
    public static let _500f: CGFloat = 500
  }
  
  public enum Opacity {
    public static let _5d: Double = 0.05
    public static let _10d: Double = 0.1
    public static let _50d: Double = 0.5
    public static let _90d: Double = 0.9
  }
}
