//
//  RestPomodoroView.swift
//  PomodoroFeature
//
//  Created by devMinseok on 8/19/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import DesignSystem

import ComposableArchitecture

public struct RestPomodoroView: View {
  @Bindable var store: StoreOf<RestPomodoroCore>
  
  public init(store: StoreOf<RestPomodoroCore>) {
    self.store = store
  }
  
  public var body: some View {
    NavigationContainer(
      leading: {
        if let selectedCategory = store.selectedCategory {
          Button(
            title: .init(selectedCategory.title),
            leftIcon: selectedCategory.image
          ) {
          }
          .buttonStyle(.box(level: .tertiary, size: .small))
        }
      },
      style: .navigation
    ) {
      VStack(spacing: .zero) {
        Spacer()
        
        VStack(spacing: Alias.Spacing.xLarge) {
          store.catRiv.view()
            .setTooltipTarget(tooltip: PomodoroDialogueTooltip.self)
            .onTapGesture {
              store.send(.catTapped)
            }
            .frame(width: 240, height: 240)

          VStack(spacing: .zero) {
            HStack(spacing: Alias.Spacing.xSmall) {
              DesignSystemAsset.Image._20Rest.swiftUIImage
              Text("휴식시간")
                .foregroundStyle(Alias.Color.Text.secondary)
                .font(Typography.header5)
            }
            Text(formatTime(from: store.restTimeBySeconds))
              .foregroundStyle(Alias.Color.Text.primary)
              .font(Typography.header1)
            if store.overTimeBySeconds > 0 {
              Text("\(formatTime(from: store.overTimeBySeconds)) 초과")
                .foregroundStyle(Alias.Color.Accent.red)
                .font(Typography.header4)
            } else {
              Spacer()
                .frame(height: 25)
            }
          }
          .padding(.horizontal, Alias.Spacing.xxLarge)
          .padding(.vertical, Alias.Spacing.medium)
          
          VStack(spacing: Alias.Spacing.medium) {
            Text("다음부터 휴식시간을 바꿀까요?")
              .foregroundStyle(Alias.Color.Text.disabled)
              .font(Typography.bodySB)
            HStack(spacing: Alias.Spacing.small) {
              Button(
                subtitle: "5분",
                leftIcon: DesignSystemAsset.Image._16MinusPrimary.swiftUIImage
              ) {
                store.send(.minus5MinuteButtonTapped)
              }
              .buttonStyle(.select(isSelected: store.changeRestTimeByMinute < 0))
              .frame(width: 68, height: 38)
              Button(
                subtitle: "5분",
                leftIcon: DesignSystemAsset.Image._16PlusPrimary.swiftUIImage
              ) {
                store.send(.plus5MinuteButtonTapped)
              }
              .buttonStyle(.select(isSelected: store.changeRestTimeByMinute > 0))
              .frame(width: 68, height: 38)
            }
          }
        }
        
        Spacer()
        
        VStack(spacing: Alias.Spacing.small) {
          Button(title: "한 번 더 집중하기") {
            store.send(.focusAgainButtonTapped)
          }
          .buttonStyle(.box(level: store.overTimeBySeconds > 0 ? .primary : .secondary, size: .large, width: .medium))
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
    .tooltipDestination(tooltip: .constant(store.dialogueTooltip))
    .task {
      await store.send(.task).finish()
    }
    .onAppear {
      store.send(.onAppear)
    }
  }
}
