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
          Rectangle()
            .fill(Alias.Color.Background.secondary)
            .frame(width: 240, height: 240)
            .setTooltipTarget(tooltip: PomodoroDialogueTooltip.self)
          
          VStack(spacing: .zero) {
            HStack(spacing: Alias.Spacing.xSmall) {
              DesignSystemAsset.Image._20Focus.swiftUIImage
              Text("집중시간")
                .foregroundStyle(Alias.Color.Text.secondary)
                .font(Typography.header5)
            }
            Text("00:00")
              .foregroundStyle(Alias.Color.Text.primary)
              .font(Typography.header1)
            if true {
              Text("00:00 초과")
                .foregroundStyle(Alias.Color.Accent.red)
                .font(Typography.header4)
            }
          }
          .padding(.horizontal, Alias.Spacing.xxLarge)
          .padding(.vertical, Alias.Spacing.medium)
        }
        
        Spacer()
        
        VStack(spacing: Alias.Spacing.small) {
          Button(title: "휴식하기") {
            
          }
          .buttonStyle(.box(level: true ? .primary : .secondary, size: .large, width: .medium))
          Button(title: "집중 끝내기") {
            
          }
          .buttonStyle(.text(level: .secondary, size: .large))
        }
      }
    }
    .background(Alias.Color.Background.primary)
    .tooltipDestination(tooltip: .constant(store.dialogueTooltip))
    .onLoad {
      store.send(.onLoad)
    }
  }
}
