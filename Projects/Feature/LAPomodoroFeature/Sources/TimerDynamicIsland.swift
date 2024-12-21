//
//  TimerDynamicIsland.swift
//  LAPomodoroFeature
//
//  Created by devMinseok on 12/18/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import WidgetKit
import SwiftUI

import DesignSystem
import PomodoroServiceInterface

struct TimerDynamicIsland {
  let context: ActivityViewContext<PomodoroActivityAttributes>
  
  var body: DynamicIsland {
    DynamicIsland {
      expanded
    } compactLeading: {
      compactLeading
    } compactTrailing: {
      compactTrailing
    } minimal: {
      minimal
    }
    .keylineTint(Alias.Color.Background.accent2)
  }
  
  @DynamicIslandExpandedContentBuilder
  var expanded: DynamicIslandExpandedContent<some View> {
    DynamicIslandExpandedRegion(.leading, priority: 1.0) {
      VStack(alignment: .leading, spacing: 2) {
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
        
        Text(
          context.state.goalDatetime,
          style: .timer
        )
        .monospacedDigit()
        .foregroundStyle(Alias.Color.Text.inverse)
        .font(context.state.isTimerOver() ? Typography.header2 : Typography.header1)
        .frame(width: 200)
        
        if context.state.isTimerOver() {
          SingleLineText {
            Text(
              Date().addingTimeInterval(3600),
              style: .timer
            )
            Text(" 초과")
          }
          .foregroundStyle(Alias.Color.Accent.red)
          .font(Typography.header5)
        }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    DynamicIslandExpandedRegion(.trailing) {
      VStack(alignment: .center) {
        DesignSystemAsset.Image.hairBall.swiftUIImage
      }
      .frame(maxHeight: .infinity)
    }
  }
  
  @ViewBuilder
  var compactLeading: some View {
    context.state.category.image
      .resizable()
      .frame(width: 20, height: 20)
  }
  
  @ViewBuilder
  var compactTrailing: some View {
    if context.state.isTimerOver() {
      DesignSystemAsset.Image._20CheckCircle.swiftUIImage
    } else {
      Text(
        context.state.goalDatetime,
        style: .timer
      )
      .font(Typography.subBodySB)
      .foregroundStyle(Alias.Color.Text.inverse)
      .monospacedDigit()
      .frame(maxWidth: 40)
    }
  }
  
  @ViewBuilder
  var minimal: some View {
    DesignSystemAsset.Image._24Timer.swiftUIImage
  }
}
