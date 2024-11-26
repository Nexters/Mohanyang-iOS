//
//  TimerLockScreenView.swift
//  LAPomodoroFeature
//
//  Created by devMinseok on 11/24/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import DesignSystem

import ComposableArchitecture

struct TimerLockScreenView: View {
  @Bindable var store: StoreOf<TimerLockScreenCore>
  
  init(store: StoreOf<TimerLockScreenCore>) {
    self.store = store
  }
  
  var body: some View {
    HStack(spacing: .zero) {
      VStack(alignment: .leading, spacing: 4) {
        HStack(alignment: .center, spacing: Alias.Spacing.xSmall) {
          if store.contentState.isRest {
            DesignSystemAsset.Image._20Rest.swiftUIImage
            Text("휴식중")
              .foregroundStyle(Alias.Color.Text.tertiary)
              .font(Typography.bodySB)
          } else {
            store.contentState.category.image
              .resizable()
              .frame(width: 20, height: 20)
            Text(store.contentState.category.title)
              .foregroundStyle(Alias.Color.Text.tertiary)
              .font(Typography.bodySB)
          }
          Spacer()
        }
        
        Text(
          timerInterval: Date()...store.contentState.goalDatetime,
          pauseTime: Date(),
          countsDown: true,
          showsHours: false
        )
        .monospacedDigit()
        .foregroundStyle(Alias.Color.Text.primary)
        .font(Typography.header2)
        
        Spacer()
      }
      
      Spacer()
      
      DesignSystemAsset.Image.hairBall.swiftUIImage
    }
    .padding(Alias.Spacing.xxLarge)
    .activityBackgroundTint(Alias.Color.Background.accent2)
    .activitySystemActionForegroundColor(Alias.Color.Background.inverse)
  }
}
