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
            .buttonStyle(.box(level: .primary, size: .large))
            .disabled(false)
            
            Button(
              title: "Button",
              leftIcon: Image(systemName: "left"),
              rightIcon: Image(systemName: "right"),
              action: { /*action*/ }
            )
            .buttonStyle(.box(level: .primary, size: .medium))
            .disabled(true)
            
            Button(
              title: "Button",
              leftIcon: Image(systemName: "left"),
              rightIcon: Image(systemName: "right"),
              action: { /*action*/ }
            )
            .buttonStyle(.box(level: .primary, size: .small))
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
            .buttonStyle(.box(level: .secondary, size: .large))
            .disabled(false)
            
            Button(
              title: "Button",
              leftIcon: Image(systemName: "left"),
              rightIcon: Image(systemName: "right"),
              action: { /*action*/ }
            )
            .buttonStyle(.box(level: .secondary, size: .medium))
            .disabled(true)
            
            Button(
              title: "Button",
              leftIcon: Image(systemName: "left"),
              rightIcon: Image(systemName: "right"),
              action: { /*action*/ }
            )
            .buttonStyle(.box(level: .secondary, size: .small))
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
            .buttonStyle(.box(level: .tertiary, size: .large))
            .disabled(false)
            
            Button(
              title: "Button",
              leftIcon: Image(systemName: "left"),
              rightIcon: Image(systemName: "right"),
              action: { /*action*/ }
            )
            .buttonStyle(.box(level: .tertiary, size: .medium))
            .disabled(true)
            
            Button(
              title: "Button",
              leftIcon: Image(systemName: "left"),
              rightIcon: Image(systemName: "right"),
              action: { /*action*/ }
            )
            .buttonStyle(.box(level: .tertiary, size: .small))
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
            .buttonStyle(.text(level: .primary, size: .large))
            .disabled(false)
            
            Button(
              title: "Button",
              leftIcon: Image(systemName: "left"),
              rightIcon: Image(systemName: "right"),
              action: { /*action*/ }
            )
            .buttonStyle(.text(level: .primary, size: .medium))
            .disabled(true)
            
            Button(
              title: "Button",
              leftIcon: Image(systemName: "left"),
              rightIcon: Image(systemName: "right"),
              action: { /*action*/ }
            )
            .buttonStyle(.text(level: .primary, size: .small))
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
            .buttonStyle(.text(level: .secondary, size: .large))
            .disabled(false)
            
            Button(
              title: "Button",
              leftIcon: Image(systemName: "left"),
              rightIcon: Image(systemName: "right"),
              action: { /*action*/ }
            )
            .buttonStyle(.text(level: .secondary, size: .medium))
            .disabled(true)
            
            Button(
              title: "Button",
              leftIcon: Image(systemName: "left"),
              rightIcon: Image(systemName: "right"),
              action: { /*action*/ }
            )
            .buttonStyle(.text(level: .secondary, size: .small))
            .disabled(false)
          }
        }
      }
      
      VStack(spacing: 40) {
        Text("Bottom CTA")
          .font(.title)
        VStack {
          Button(
            title: "Button",
            action: { /*action*/ }
          )
          .buttonStyle(.box(level: .primary, size: .large, width: .low))
          .padding(.horizontal, 20)
        }
      }
    }
  }
}

#Preview {
  ButtonDetailView()
}
