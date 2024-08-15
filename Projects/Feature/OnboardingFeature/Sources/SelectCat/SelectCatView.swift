//
//  SelectCatView.swift
//  OnboardingFeature
//
//  Created by 김지현 on 8/14/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import DesignSystem

import ComposableArchitecture

public struct SelectCatView: View {
  @Bindable var store: StoreOf<SelectCatCore>

  public init(store: StoreOf<SelectCatCore>) {
    self.store = store
  }

  public var body: some View {
    NavigationContainer(
      title: Text("고양이 선택"),
      style: .navigation,
      navBackground: .clear
    ) {
      VStack {
        VStack(spacing: Alias.Spacing.xSmall) {
          Text("어떤 고양이와 함께할까요?")
            .font(Typography.header3)
            .foregroundStyle(Alias.Color.Text.primary)
          Text("언제든지 다른 고양이를 선택할 수 있어요")
            .font(Typography.bodyR)
            .foregroundStyle(Alias.Color.Text.secondary)
        }

        Spacer(minLength: Alias.Spacing.xLarge)

        VStack {
          CatPushNotificationExampleView(cat: store.cat)
        }

        Button(title: "이 고양이와 함께하기") {
          // click!
        }
        .buttonStyle(.box(level: .primary, size: .large, width: .medium))
      }
    }
    .background {
      Alias.Color.Background.primary
        .ignoresSafeArea()
    }
  }
}

struct CatPushNotificationExampleView: View {
  var cat: (any CatFactoryProtocol)?
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: Alias.BorderRadius.xSmall,style: .circular)
        .foregroundStyle(Alias.Color.Background.secondary)

      if let cat = cat {
        HStack {
          Image(systemName: "star.fill")
          VStack(spacing: 0) {
            Text("모하냥")
              .font(Typography.bodyR)
              .foregroundStyle(Alias.Color.Text.primary)
            Text(cat.pushNotificationTitle)
              .font(Typography.subBodyR)
              .foregroundStyle(Alias.Color.Text.primary)
          }
          Spacer()
          VStack(spacing: 0) {
            Text("지금")
              .font(Typography.subBodyR)
              .foregroundStyle(Alias.Color.Text.secondary)
            Spacer()
          }
        }
        .padding(.all, Alias.Spacing.large)
      } else {
        Text("고양이를 선택하면\n딴 짓 방해알림 예시를 보여드려요")
          .font(Typography.bodyR)
          .foregroundStyle(Alias.Color.Text.tertiary)
          .multilineTextAlignment(.center)
          .padding(.all, Alias.Spacing.large)
      }
    }
  }
}
