//
//  LoadingView.swift
//  Feature
//
//  Created by 김지현 on 11/25/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import DesignSystem

import Lottie

struct LoadingView: View {
  var body: some View {
    VStack {
      Spacer()
      ZStack {
        RoundedRectangle(cornerRadius: Alias.BorderRadius.medium)
          .foregroundStyle(Alias.Color.Background.inverse)
          .opacity(Global.Opacity._90d)
        LottieView(animation: AnimationAsset.lotiSpinner.animation)
          .playing(loopMode: .loop)
      }
      .frame(width: 82, height: 82)
      Spacer()
    }
    .presentationBackground(.clear)
  }
}
