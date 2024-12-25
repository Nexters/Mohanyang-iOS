//
//  TimerLockScreenView.swift
//  LAPomodoroFeature
//
//  Created by devMinseok on 11/24/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI
import WidgetKit

import DesignSystem
import PomodoroServiceInterface

/// 아래 Text사용하면 update시 LiveActivity가 멈추는 버그 있음
/// Text(timerInterval:,pauseTime:,countsDown:,showsHours:)
struct TimerLockScreenView: View {
  let context: ActivityViewContext<PomodoroActivityAttributes>
  
  var body: some View {
    HStack(spacing: .zero) {
      VStack(alignment: .leading, spacing: 4) {
        HStack(alignment: .center, spacing: Alias.Spacing.xSmall) {
          if context.state.isRest {
            DesignSystemAsset.Image._20Rest.swiftUIImage
            Text("휴식중")
              .foregroundStyle(Alias.Color.Text.tertiary)
              .font(Typography.bodySB)
          } else {
            context.state.category.image
              .resizable()
              .frame(width: 20, height: 20)
            Text(context.state.category.title)
              .foregroundStyle(Alias.Color.Text.tertiary)
              .font(Typography.bodySB)
          }
          Spacer()
        }
        
        if context.state.isTimerOver() {
          Text("0:00")
            .monospacedDigit()
            .foregroundStyle(Alias.Color.Text.primary)
            .font(Typography.header2)
          SingleLineText {
            Text(
              context.state.goalDatetime,
              style: .timer
            )
            .monospacedDigit()
            Text(" 초과")
          }
          .foregroundStyle(Alias.Color.Accent.red)
          .font(Typography.header5)
        } else {
          Text(
            context.state.goalDatetime,
            style: .timer
          )
          .monospacedDigit()
          .foregroundStyle(Alias.Color.Text.primary)
          .font(Typography.header1)
        }
      }
      
      Spacer()
      
      DesignSystemAsset.Image.hairBall.swiftUIImage
    }
    .padding(Alias.Spacing.xxLarge)
    .frame(height: 126)
    .activityBackgroundTint(Alias.Color.Background.accent2)
    .activitySystemActionForegroundColor(Alias.Color.Background.inverse)
  }
}
