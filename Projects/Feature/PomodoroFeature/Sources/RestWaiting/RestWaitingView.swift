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
              ) {
              }
              .buttonStyle(.box(level: .tertiary, size: .small))
            }
            Text(formatTime(from: store.restWaitingTimeBySeconds))
              .foregroundStyle(Alias.Color.Text.primary)
              .font(Typography.header1)
            if store.overTimeBySeconds > 0 {
              Text("\(formatTime(from: store.overTimeBySeconds)) 초과")
                .foregroundStyle(Alias.Color.Accent.red)
                .font(Typography.header4)
            }
          }
          
          ZStack {
            LottieView(animation: AnimationAsset.lotiCompleteFocus.animation)
            if true {
              LottieView(animation: AnimationAsset.lotiParticle.animation)
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
                leftIcon: DesignSystemAsset.Image._16MinusPrimary.swiftUIImage
              ) {
                store.send(.minus5MinuteButtonTapped)
              }
              .buttonStyle(.select(isSelected: false))
              .frame(width: 68, height: 38)
              Button(
                subtitle: "5분",
                leftIcon: DesignSystemAsset.Image._16PlusPrimary.swiftUIImage
              ) {
                store.send(.plus5MinuteButtonTapped)
              }
              .buttonStyle(.select(isSelected: false))
              .frame(width: 68, height: 38)
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
    .navigationDestination(
      item: $store.scope(
        state: \.restPomodoro,
        action: \.restPomodoro
      )
    ) { store in
      RestPomodoroView(store: store)
    }
    .onLoad {
      store.send(.onLoad)
    }
  }
}
