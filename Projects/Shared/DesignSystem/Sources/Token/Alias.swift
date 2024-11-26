//
//  Alias.swift
//  DesignSystem
//
//  Created by devMinseok on 8/5/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

public enum Alias {
  public enum Color {
    public enum Icon {
      public static let primary = Global.Color.gray700
      public static let secondary = Global.Color.gray500
      public static let tertiary = Global.Color.gray300
      public static let disabled = Global.Color.gray200
      public static let inverse = Global.Color.white
    }
    
    public enum Text {
      public static let primary = Global.Color.gray800
      public static let secondary = Global.Color.gray600
      public static let tertiary = Global.Color.gray500
      public static let disabled = Global.Color.gray300
      public static let inverse = Global.Color.white
    }
    
    public enum Background {
      public static let primary = Global.Color.gray50
      public static let secondary = Global.Color.gray100
      public static let tertiary = Global.Color.gray400
      public static let inverse = Global.Color.gray900
      public static let accent1 = Global.Color.orange500
      public static let accent2 = Global.Color.orange50
    }
    
    public enum Accent {
      public static let red = Global.Color.red300
    }
  }
  
  public enum Spacing {
    public static let xSmall = Global.Dimension._4f
    public static let xxSmall = Global.Dimension._2f
    public static let small = Global.Dimension._8f
    public static let medium = Global.Dimension._12f
    public static let large = Global.Dimension._16f
    public static let xLarge = Global.Dimension._20f
    public static let xxLarge = Global.Dimension._24f
    public static let xxxLarge = Global.Dimension._32f
  }
  
  public enum BorderRadius {
    public static let xSmall = Global.Dimension._12f
    public static let small = Global.Dimension._16f
    public static let medium = Global.Dimension._20f
    public static let large = Global.Dimension._24f
    public static let max = Global.Dimension._500f
  }
  
  public enum BorderWidth {
    public enum Stroke {
      public static let small: CGFloat = 0.5
      public static let medium: CGFloat = 1
      public static let large: CGFloat = 2
    }
    
    public enum Icon {
      public static let xSmall: CGFloat = 1.4
      public static let small: CGFloat = 1.6
      public static let medium: CGFloat = 2
      public static let large: CGFloat = 2.6
      public static let xLarge: CGFloat = 4
    }
  }
  
  public enum Size {
    public enum Icon {
      public static let xSmall = Global.Dimension._16f
      public static let small = Global.Dimension._20f
      public static let medium = Global.Dimension._24f
      public static let large = Global.Dimension._32f
      public static let xLarge = Global.Dimension._48f
    }
    
    public enum ButtonHeight {
      public static let small: CGFloat = 40
      public static let medium: CGFloat = 52
      public static let large: CGFloat = 60
    }
    
    public enum ButtonWidth {
      public static let fixed: CGFloat = 200
    }
  }
  
  public enum Interaction {
    public static let hover = Global.Opacity._10d
    public static let pressed = Global.Opacity._5d
  }
}
