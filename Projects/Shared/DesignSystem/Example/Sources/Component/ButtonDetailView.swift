//
//  ButtonDetailView.swift
//  DesignSystemExample
//
//  Created by devMinseok on 8/6/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import DesignSystem

struct ButtonDetailView: View {
  var body: some View {
    ScrollView {
      VStack(spacing: 40) {
        Text("Box")
          .font(.title)
        VStack {
          Text("Primary")
            .frame(maxWidth: .infinity)
            .foregroundStyle(Global.Color.white)
            .background(Global.Color.black)
          HStack(spacing: 10) {
            Button(
              title: "Button",
              leftIcon: Image(systemName: "left"),
              rightIcon: Image(systemName: "right"),
              action: { /*action*/ }
            )
            .buttonStyle(.box(size: .large, color: .primary))
            .disabled(false)
            
            Button(
              title: "Button",
              leftIcon: Image(systemName: "left"),
              rightIcon: Image(systemName: "right"),
              action: { /*action*/ }
            )
            .buttonStyle(.box(size: .medium, color: .primary))
            .disabled(true)
            
            Button(
              title: "Button",
              leftIcon: Image(systemName: "left"),
              rightIcon: Image(systemName: "right"),
              action: { /*action*/ }
            )
            .buttonStyle(.box(size: .small, color: .primary))
            .disabled(false)
          }
        }
        
        VStack {
          Text("Secondary")
            .frame(maxWidth: .infinity)
            .foregroundStyle(Global.Color.white)
            .background(Global.Color.black)
          HStack(spacing: 10) {
            Button(
              title: "Button",
              leftIcon: Image(systemName: "left"),
              rightIcon: Image(systemName: "right"),
              action: { /*action*/ }
            )
            .buttonStyle(.box(size: .large, color: .secondary))
            .disabled(false)
            
            Button(
              title: "Button",
              leftIcon: Image(systemName: "left"),
              rightIcon: Image(systemName: "right"),
              action: { /*action*/ }
            )
            .buttonStyle(.box(size: .medium, color: .secondary))
            .disabled(true)
            
            Button(
              title: "Button",
              leftIcon: Image(systemName: "left"),
              rightIcon: Image(systemName: "right"),
              action: { /*action*/ }
            )
            .buttonStyle(.box(size: .small, color: .secondary))
            .disabled(false)
          }
        }
        
        VStack {
          Text("Tertiary")
            .frame(maxWidth: .infinity)
            .foregroundStyle(Global.Color.white)
            .background(Global.Color.black)
          HStack(spacing: 10) {
            Button(
              title: "Button",
              leftIcon: Image(systemName: "left"),
              rightIcon: Image(systemName: "right"),
              action: { /*action*/ }
            )
            .buttonStyle(.box(size: .large, color: .tertiary))
            .disabled(false)
            
            Button(
              title: "Button",
              leftIcon: Image(systemName: "left"),
              rightIcon: Image(systemName: "right"),
              action: { /*action*/ }
            )
            .buttonStyle(.box(size: .medium, color: .tertiary))
            .disabled(true)
            
            Button(
              title: "Button",
              leftIcon: Image(systemName: "left"),
              rightIcon: Image(systemName: "right"),
              action: { /*action*/ }
            )
            .buttonStyle(.box(size: .small, color: .tertiary))
            .disabled(false)
          }
          
        }
      }
      
      VStack(spacing: 40) {
        Text("Text")
          .font(.title)
        VStack {
          Text("Primary")
            .frame(maxWidth: .infinity)
            .foregroundStyle(Global.Color.white)
            .background(Global.Color.black)
          HStack(spacing: 10) {
            Button(
              title: "Button",
              leftIcon: Image(systemName: "left"),
              rightIcon: Image(systemName: "right"),
              action: { /*action*/ }
            )
            .buttonStyle(.text(size: .large, color: .primary))
            .disabled(false)
            
            Button(
              title: "Button",
              leftIcon: Image(systemName: "left"),
              rightIcon: Image(systemName: "right"),
              action: { /*action*/ }
            )
            .buttonStyle(.text(size: .medium, color: .primary))
            .disabled(true)
            
            Button(
              title: "Button",
              leftIcon: Image(systemName: "left"),
              rightIcon: Image(systemName: "right"),
              action: { /*action*/ }
            )
            .buttonStyle(.text(size: .small, color: .primary))
            .disabled(false)
          }
        }
        
        VStack {
          Text("Secondary")
            .frame(maxWidth: .infinity)
            .foregroundStyle(Global.Color.white)
            .background(Global.Color.black)
          HStack(spacing: 10) {
            Button(
              title: "Button",
              leftIcon: Image(systemName: "left"),
              rightIcon: Image(systemName: "right"),
              action: { /*action*/ }
            )
            .buttonStyle(.text(size: .large, color: .secondary))
            .disabled(false)
            
            Button(
              title: "Button",
              leftIcon: Image(systemName: "left"),
              rightIcon: Image(systemName: "right"),
              action: { /*action*/ }
            )
            .buttonStyle(.text(size: .medium, color: .secondary))
            .disabled(true)
            
            Button(
              title: "Button",
              leftIcon: Image(systemName: "left"),
              rightIcon: Image(systemName: "right"),
              action: { /*action*/ }
            )
            .buttonStyle(.text(size: .small, color: .secondary))
            .disabled(false)
          }
        }
        
//        VStack {
//          Text("Secondary")
//            .frame(maxWidth: .infinity)
//            .foregroundStyle(Global.Color.white)
//            .background(Global.Color.black)
//          HStack(spacing: 10) {
//            Button(
//              icon: Image(systemName: "center"),
//              action: { /*action*/ }
//            )
//            .buttonStyle(.round(color: .secondary))
//            
//            Button(
//              icon: Image(systemName: "center"),
//              action: { /*action*/ }
//            )
//            .buttonStyle(.round(color: .primary))
//          }
//        }
        
        
        
      }
    }
  }
}

#Preview {
  ButtonDetailView()
}
