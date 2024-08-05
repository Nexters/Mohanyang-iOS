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
    public static let white = DesignSystemAsset.white.swiftUIColor
    public static let black = DesignSystemAsset.black.swiftUIColor
    
    public static let gray50 = DesignSystemAsset.gray50.swiftUIColor
    public static let gray100 = DesignSystemAsset.gray100.swiftUIColor
    public static let gray200 = DesignSystemAsset.gray200.swiftUIColor
    public static let gray300 = DesignSystemAsset.gray300.swiftUIColor
    public static let gray400 = DesignSystemAsset.gray400.swiftUIColor
    public static let gray500 = DesignSystemAsset.gray500.swiftUIColor
    public static let gray600 = DesignSystemAsset.gray600.swiftUIColor
    public static let gray700 = DesignSystemAsset.gray700.swiftUIColor
    public static let gray800 = DesignSystemAsset.gray800.swiftUIColor
    public static let gray900 = DesignSystemAsset.gray900.swiftUIColor
    
    public static let orange50 = DesignSystemAsset.orange50.swiftUIColor
    public static let orange100 = DesignSystemAsset.orange100.swiftUIColor
    public static let orange200 = DesignSystemAsset.orange200.swiftUIColor
    public static let orange300 = DesignSystemAsset.orange300.swiftUIColor
    public static let orange400 = DesignSystemAsset.orange400.swiftUIColor
    public static let orange500 = DesignSystemAsset.orange500.swiftUIColor
    public static let orange600 = DesignSystemAsset.orange600.swiftUIColor
    public static let orange700 = DesignSystemAsset.orange700.swiftUIColor
    public static let orange800 = DesignSystemAsset.orange800.swiftUIColor
    public static let orange900 = DesignSystemAsset.orange900.swiftUIColor
    
    public static let red50 = DesignSystemAsset.red50.swiftUIColor
    public static let red100 = DesignSystemAsset.red100.swiftUIColor
    public static let red200 = DesignSystemAsset.red200.swiftUIColor
    public static let red300 = DesignSystemAsset.red300.swiftUIColor
    public static let red400 = DesignSystemAsset.red400.swiftUIColor
    public static let red500 = DesignSystemAsset.red500.swiftUIColor
    public static let red600 = DesignSystemAsset.red600.swiftUIColor
    public static let red700 = DesignSystemAsset.red700.swiftUIColor
    public static let red800 = DesignSystemAsset.red800.swiftUIColor
    public static let red900 = DesignSystemAsset.red900.swiftUIColor
  }
  
  public enum Dimension {
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
