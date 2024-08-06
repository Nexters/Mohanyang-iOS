//
//  AliasTokenDetailView.swift
//  DesignSystemExample
//
//  Created by devMinseok on 8/6/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import DesignSystem

struct AliasTokenDetailView: View {
  var body: some View {
    List {
      Section("Icon") {
        colorItem(Alias.Color.Icon.primary, name: "Primary")
        colorItem(Alias.Color.Icon.secondary, name: "Secondary")
        colorItem(Alias.Color.Icon.tertiary, name: "Tertiary")
        colorItem(Alias.Color.Icon.disabled, name: "Disabled")
        colorItem(Alias.Color.Icon.inverse, name: "Inverse")
      }
     
      Section("Text") {
        colorItem(Alias.Color.Text.primary, name: "Primary")
        colorItem(Alias.Color.Text.secondary, name: "Secondary")
        colorItem(Alias.Color.Text.tertiary, name: "Tertiary")
        colorItem(Alias.Color.Text.disabled, name: "Disabled")
        colorItem(Alias.Color.Text.inverse, name: "Inverse")
      }
      
      Section("Background") {
        colorItem(Alias.Color.Background.primary, name: "Primary")
        colorItem(Alias.Color.Background.secondary, name: "Secondary")
        colorItem(Alias.Color.Background.tertiary, name: "Tertiary")
        colorItem(Alias.Color.Background.inverse, name: "Inverse")
        colorItem(Alias.Color.Background.accent1, name: "Accent_1")
        colorItem(Alias.Color.Background.accent2, name: "Accent_2")
      }
      
      Section("Accent") {
        colorItem(Alias.Color.Accent.red, name: "Red")
      }
      
      Section("Spacing") {
        spacingItem(Alias.Spacing.xSmall, name: "xSmall")
        spacingItem(Alias.Spacing.small, name: "Small")
        spacingItem(Alias.Spacing.medium, name: "Medium")
        spacingItem(Alias.Spacing.large, name: "Large")
        spacingItem(Alias.Spacing.xLarge, name: "xLarge")
        spacingItem(Alias.Spacing.xxLarge, name: "2xLarge")
        spacingItem(Alias.Spacing.xxxLarge, name: "3xLarge")
      }
      
      Section("Border Radius") {
        borderRadiusItem(Alias.BorderRadius.xSmall, name: "xSmall")
        borderRadiusItem(Alias.BorderRadius.small, name: "Small")
        borderRadiusItem(Alias.BorderRadius.medium, name: "Medium")
        borderRadiusItem(Alias.BorderRadius.large, name: "Large")
        borderRadiusItem(Alias.BorderRadius.max, name: "Max")
      }
      
      Section("Border Width") {
        borderWidthItem(Alias.BorderWidth.Stroke.small, name: "Stroke - Small")
        borderWidthItem(Alias.BorderWidth.Stroke.medium, name: "Stroke - Medium")
        borderWidthItem(Alias.BorderWidth.Stroke.large, name: "Stroke - Large")
        borderWidthItem(Alias.BorderWidth.Icon.xSmall, name: "Icon - xLarge")
        borderWidthItem(Alias.BorderWidth.Icon.small, name: "Icon - Small")
        borderWidthItem(Alias.BorderWidth.Icon.medium, name: "Icon - Medium")
        borderWidthItem(Alias.BorderWidth.Icon.large, name: "Icon - Large")
        borderWidthItem(Alias.BorderWidth.Icon.xLarge, name: "Icon - xLarge")
      }
      
      Section("Size") {
        sizeItem(Alias.Size.Icon.xSmall, name: "Icon - xSmall")
        sizeItem(Alias.Size.Icon.small, name: "Icon - Small")
        sizeItem(Alias.Size.Icon.medium, name: "Icon - Medium")
        sizeItem(Alias.Size.Icon.large, name: "Icon - Large")
        sizeItem(Alias.Size.Icon.xLarge, name: "Icon - xLarge")
        sizeItem(Alias.Size.ButtonHeight.small, name: "ButtonHeight - Small")
        sizeItem(Alias.Size.ButtonHeight.medium, name: "ButtonHeight - Medium")
        sizeItem(Alias.Size.ButtonHeight.large, name: "ButtonHeight - Large")
        sizeItem(Alias.Size.ButtonWidth.fixed, name: "ButtonWidth - Fixed")
      }
      
      Section("Interaction") {
        interactionItem(interaction: Alias.Interaction.hover, name: "Hover")
        interactionItem(interaction: Alias.Interaction.pressed, name: "Pressed")
      }
    }
  }
  
  func colorItem(_ Color: Color, name: String) -> some View {
    HStack {
      Text(name)
      Spacer()
      Color
        .frame(width: 30, height: 30)
    }
  }
  
  func spacingItem(_ spacing: CGFloat, name: String) -> some View {
    HStack {
      Text(name)
      Spacer()
      Global.Color.orange50
        .frame(width: spacing, height: spacing)
    }
  }
  
  func borderRadiusItem(_ radius: CGFloat, name: String) -> some View {
    HStack {
      Text(name)
      Spacer()
      Global.Color.orange50
        .frame(width: 30, height: 30)
        .clipShape(RoundedRectangle(cornerRadius: radius))
    }
  }
  
  func borderWidthItem(_ width: CGFloat, name: String) -> some View {
    HStack {
      Text(name)
      Spacer()
      Global.Color.orange50
        .border(Global.Color.orange500, width: width)
        .frame(width: 30, height: 30)
    }
  }
  
  func sizeItem(_ size: CGFloat, name: String) -> some View {
    HStack {
      Text(name)
      Spacer()
      Global.Color.orange50
        .frame(width: size, height: size)
    }
  }
  
  func interactionItem(interaction: Color, name: String) -> some View {
    HStack {
      Text(name)
      Spacer()
      interaction
        .frame(width: 30, height: 30)
    }
  }
}
