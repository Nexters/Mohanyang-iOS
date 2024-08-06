//
//  GlobalTokenDetailView.swift
//  DesignSystemExample
//
//  Created by devMinseok on 8/6/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import DesignSystem

struct GlobalTokenDetailView: View {
  let rows: [GridItem] = [
    .init(.adaptive(minimum: 50, maximum: 50), spacing: 5, alignment: .bottom),
    .init(.adaptive(minimum: 50, maximum: 50), spacing: 5, alignment: .bottom)
  ]
  
  var body: some View {
    ScrollView {
      VStack(spacing: 20) {
        VStack(alignment: .leading) {
          Text("Color Tokens")
            .foregroundStyle(Global.Color.white)
            .frame(maxWidth: .infinity)
            .background(Global.Color.black)
          VStack(alignment: .leading, spacing: 5) {
            Text("Black/White")
            LazyVGrid(columns: rows) {
              colorBox(Global.Color.white, name: "White")
              colorBox(Global.Color.black, name: "Black")
            }
          }
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.horizontal)
          
          VStack(alignment: .leading, spacing: 5) {
            Text("Gray")
            LazyVGrid(columns: rows) {
              colorBox(Global.Color.gray50, name: "50")
              colorBox(Global.Color.gray100, name: "100")
              colorBox(Global.Color.gray200, name: "200")
              colorBox(Global.Color.gray300, name: "300")
              colorBox(Global.Color.gray400, name: "400")
              colorBox(Global.Color.gray500, name: "500")
              colorBox(Global.Color.gray600, name: "600")
              colorBox(Global.Color.gray700, name: "700")
              colorBox(Global.Color.gray800, name: "800")
              colorBox(Global.Color.gray900, name: "900")
            }
          }
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.horizontal)
          
          VStack(alignment: .leading, spacing: 5) {
            Text("Orange")
            LazyVGrid(columns: rows) {
              colorBox(Global.Color.orange50, name: "50")
              colorBox(Global.Color.orange100, name: "100")
              colorBox(Global.Color.orange200, name: "200")
              colorBox(Global.Color.orange300, name: "300")
              colorBox(Global.Color.orange400, name: "400")
              colorBox(Global.Color.orange500, name: "500")
              colorBox(Global.Color.orange600, name: "600")
              colorBox(Global.Color.orange700, name: "700")
              colorBox(Global.Color.orange800, name: "800")
              colorBox(Global.Color.orange900, name: "900")
            }
          }
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.horizontal)
          
          VStack(alignment: .leading, spacing: 5) {
            Text("Red")
            LazyVGrid(columns: rows) {
              colorBox(Global.Color.red50, name: "50")
              colorBox(Global.Color.red100, name: "100")
              colorBox(Global.Color.red200, name: "200")
              colorBox(Global.Color.red300, name: "300")
              colorBox(Global.Color.red400, name: "400")
              colorBox(Global.Color.red500, name: "500")
              colorBox(Global.Color.red600, name: "600")
              colorBox(Global.Color.red700, name: "700")
              colorBox(Global.Color.red800, name: "800")
              colorBox(Global.Color.red900, name: "900")
            }
          }
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.horizontal)
        }
        
        VStack(alignment: .leading) {
          Text("Dimension Tokens")
            .foregroundStyle(Global.Color.white)
            .frame(maxWidth: .infinity)
            .background(Global.Color.black)
          VStack(alignment: .leading, spacing: 5) {
            LazyVGrid(columns: rows) {
              dimensionBox(Global.Dimension._4f)
              dimensionBox(Global.Dimension._8f)
              dimensionBox(Global.Dimension._12f)
              dimensionBox(Global.Dimension._16f)
              dimensionBox(Global.Dimension._20f)
              dimensionBox(Global.Dimension._24f)
              dimensionBox(Global.Dimension._28f)
              dimensionBox(Global.Dimension._32f)
              dimensionBox(Global.Dimension._48f)
            }
          }
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.horizontal)
        }
        
        VStack(alignment: .leading) {
          Text("Opacity Tokens")
            .foregroundStyle(Global.Color.white)
            .frame(maxWidth: .infinity)
            .background(Global.Color.black)
          VStack(alignment: .leading, spacing: 5) {
            LazyVGrid(columns: rows) {
              opacityBox(opacity: Global.Opacity._5d)
              opacityBox(opacity: Global.Opacity._10d)
              opacityBox(opacity: Global.Opacity._50d)
              opacityBox(opacity: Global.Opacity._90d)
            }
          }
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.horizontal)
        }
      }
    }
  }
  
  func colorBox(_ color: Color, name: String) -> some View {
    VStack(alignment: .center) {
      color
        .frame(width: 50, height: 50)
        .border(.black, width: 1)
      Text(name)
        .font(.caption2)
    }
  }
  
  func dimensionBox(_ dimension: CGFloat) -> some View {
    VStack(alignment: .center) {
      Rectangle()
        .fill(Global.Color.orange50)
        .frame(width: dimension, height: dimension)
      Text(String(format: "%.0f", dimension))
        .font(.caption2)
    }
  }
  
  func opacityBox(opacity: Double) -> some View {
    VStack(alignment: .center) {
      Rectangle()
        .fill(Global.Color.black.opacity(opacity))
        .frame(width: 50, height: 50)
      Text(String(format: "%.2f", opacity))
        .font(.caption2)
    }
  }
}
