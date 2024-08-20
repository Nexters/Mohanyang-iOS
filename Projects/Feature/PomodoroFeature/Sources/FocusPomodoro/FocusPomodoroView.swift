//
//  FocusPomodoroView.swift
//  PomodoroFeature
//
//  Created by devMinseok on 8/18/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import DesignSystem

import ComposableArchitecture
import RiveRuntime

public struct FocusPomodoroView: View {
  @Bindable var store: StoreOf<FocusPomodoroCore>
  
  public init(store: StoreOf<FocusPomodoroCore>) {
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
          ZStack {
            Rectangle()
              .fill(Alias.Color.Background.secondary)
            store.catRiv.view()
              .setTooltipTarget(tooltip: PomodoroDialogueTooltip.self)
              .onTapGesture {
                store.catRiv.triggerInput(store.selectedCat.rivTriggerName)
              }
          }
          .frame(width: 240, height: 240)

          VStack(spacing: .zero) {
            HStack(spacing: Alias.Spacing.xSmall) {
              DesignSystemAsset.Image._20Focus.swiftUIImage
              Text("집중시간")
                .foregroundStyle(Alias.Color.Text.secondary)
                .font(Typography.header5)
            }
            Text(formatTime(from: store.focusTimeBySeconds))
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
        }
        
        Spacer()
        
        VStack(spacing: Alias.Spacing.small) {
          Button(title: "휴식하기") {
            store.send(.takeRestButtonTapped)
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
    .tooltipDestination(tooltip: .constant(store.dialogueTooltip))
    .navigationDestination(
      item: $store.scope(
        state: \.restWaiting,
        action: \.restWaiting
      )
    ) { store in
      RestWaitingView(store: store)
    }
    .task {
      await store.send(.task).finish()
    }
    .onAppear {
      store.send(.onAppear)
    }
  }
}
