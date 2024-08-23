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
      
      VStack(spacing: 40) {
        Text("Icon")
          .font(.title)
        HStack {
          Button(
            icon: Image(systemName: "left"),
            action: { /*action*/ }
          )
          .buttonStyle(.icon(isFilled: false, level: .primary))
          Button(
            icon: Image(systemName: "right"),
            action: { /*action*/ }
          )
          .buttonStyle(.icon(isFilled: true, level: .primary))
          Button(
            icon: Image(systemName: "left"),
            action: { /*action*/ }
          )
          .buttonStyle(.icon(isFilled: false, level: .primary))
          .disabled(true)
          Button(
            icon: Image(systemName: "right"),
            action: { /*action*/ }
          )
          .buttonStyle(.icon(isFilled: true, level: .primary))
          .disabled(true)
        }
      }
      
      VStack(spacing: 40) {
        Text("Round")
          .font(.title)
        HStack {
          Button(
            icon: Image(systemName: "left"),
            action: { /*action*/ }
          )
          .buttonStyle(.round(level: .primary))
          Button(
            icon: Image(systemName: "right"),
            action: { /*action*/ }
          )
          .buttonStyle(.round(level: .secondary))
        }
      }
      
      VStack(spacing: 40) {
        Text("Select")
          .font(.title)
        HStack {
          Button(
            title: "Title",
            subtitle: "subTitle",
            leftIcon: Image(systemName: "left"),
            rightIcon: Image(systemName: "right"),
            action: {
              /*action*/
            }
          )
          .buttonStyle(.select(isSelected: true))
          .frame(height: 80)
          Button(
            title: "Title",
            subtitle: "subTitle",
            leftIcon: Image(systemName: "left"),
            rightIcon: Image(systemName: "right"),
            action: { /*action*/ }
          )
          .buttonStyle(.select(isSelected: false))
          .frame(height: 80)
          Button(
            title: "Title",
            subtitle: "subTitle",
            leftIcon: Image(systemName: "left"),
            rightIcon: Image(systemName: "right"),
            action: { /*action*/ }
          )
          .buttonStyle(.select(isSelected: false))
          .disabled(true)
          .frame(height: 80)
        }
      }
      .padding(.horizontal, 20)
      
      VStack(spacing: 40) {
        Text("Select List")
          .font(.title)
        VStack {
          Button(
            title: "Title",
            subtitle: "subTitle",
            leftIcon: Image(systemName: "left"),
            rightIcon: Image(systemName: "right"),
            action: {
              /*action*/
            }
          )
          .buttonStyle(.selectList(isSelected: true))
          Button(
            title: "Title",
            subtitle: "subTitle",
            leftIcon: Image(systemName: "left"),
            rightIcon: Image(systemName: "right"),
            action: { /*action*/ }
          )
          .buttonStyle(.selectList(isSelected: false))
        }
      }
      .padding(.horizontal, 20)
    }
  }
}

#Preview {
  ButtonDetailView()
}
