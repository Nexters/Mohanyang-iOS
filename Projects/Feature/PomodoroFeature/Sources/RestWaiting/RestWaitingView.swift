//
//  RestWaitingView.swift
//  PomodoroFeature
//
//  Created by devMinseok on 8/20/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import DesignSystem

import ComposableArchitecture
import Lottie
import DatadogRUM

public struct RestWaitingView: View {
  @Bindable var store: StoreOf<RestWaitingCore>
  
  public init(store: StoreOf<RestWaitingCore>) {
    self.store = store
  }
  
  public var body: some View {
    NavigationContainer(
      leading: { Spacer() },
      style: .navigation
    ) {
      VStack(spacing: .zero) {
        Spacer()
        
        VStack(spacing: Alias.Spacing.xLarge) {
          VStack(spacing: Alias.Spacing.small) {
            if let selectedCategory = store.selectedCategory {
              Button(
                title: .init(selectedCategory.title),
                leftIcon: selectedCategory.image
              ) {}
              .buttonStyle(.box(level: .tertiary, size: .small))
            }
            Text(formatTime(from: store.focusedTimeBySeconds))
              .foregroundStyle(Alias.Color.Text.primary)
              .font(Typography.header1)
            if store.overTimeBySeconds > 0 {
              Text("\(formatTime(from: store.overTimeBySeconds)) 초과")
                .foregroundStyle(Alias.Color.Accent.red)
                .font(Typography.header4)
            }
          }
          
          ZStack {
            LottieView(animation: AnimationAsset.completeFocus.animation)
              .playing(loopMode: .playOnce)
            if store.source == .overtimeFromFocusPomodoro {
              LottieView(animation: AnimationAsset.particle.animation)
                .playing(loopMode: .playOnce)
            }
          }
          .frame(width: 240, height: 240)
          
          VStack(spacing: Alias.Spacing.medium) {
            Text("다음부터 집중 시간을 바꿀까요?")
              .foregroundStyle(Alias.Color.Text.disabled)
              .font(Typography.bodySB)
            HStack(spacing: Alias.Spacing.small) {
              Button(
                subtitle: "5분",
                leftIcon: DesignSystemAsset.Image._16MinusTertiary.swiftUIImage
              ) {
                store.send(.minus5MinuteButtonTapped)
              }
              .buttonStyle(
                .selectChip(
                  isSelected: store.changeFocusTimeByMinute < 0,
                  isDisabled: store.minus5MinuteButtonDisabled
                )
              )
              Button(
                subtitle: "5분",
                leftIcon: DesignSystemAsset.Image._16PlusTertiary.swiftUIImage
              ) {
                store.send(.plus5MinuteButtonTapped)
              }
              .buttonStyle(
                .selectChip(
                  isSelected: store.changeFocusTimeByMinute > 0,
                  isDisabled: store.plus5MinuteButtonDisabled
                )
              )
            }
          }
        }
        
        Spacer()
        
        VStack(spacing: Alias.Spacing.small) {
          Button(title: "휴식 시작하기") {
            store.send(.takeRestButtonTapped)
          }
          .buttonStyle(.box(level: .primary, size: .large, width: .medium))
          Button(title: "집중 끝내기") {
            store.send(.endFocusButtonTapped)
          }
          .buttonStyle(.text(level: .secondary, size: .large))
        }
        .padding(.bottom, Alias.Spacing.xLarge)
      }
    }
    .background(Alias.Color.Background.primary)
    .toastDestination(toast: $store.toast)
    .task {
      await store.send(.task).finish()
    }
    .trackRUMView(name: "휴식대기화면")
  }
}
