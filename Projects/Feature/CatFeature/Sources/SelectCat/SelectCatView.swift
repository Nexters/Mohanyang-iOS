//
//  SelectCatView.swift
//  OnboardingFeature
//
//  Created by 김지현 on 8/14/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import CatServiceInterface
import DesignSystem

import ComposableArchitecture
import RiveRuntime

public struct SelectCatView: View {
  @Bindable var store: StoreOf<SelectCatCore>

  public init(store: StoreOf<SelectCatCore>) {
    self.store = store
  }

  public var body: some View {
    NavigationContainer(
      title: Text("고양이 선택"),
      style: .navigation
    ) {
      VStack(spacing: 0) {
        Spacer(minLength: Alias.Spacing.xLarge)

        HStack {
          VStack(spacing: Alias.Spacing.xSmall) {
            Text("어떤 고양이와 함께할까요?")
              .font(Typography.header3)
              .foregroundStyle(Alias.Color.Text.primary)
            Text("언제든지 다른 고양이를 선택할 수 있어요")
              .font(Typography.bodyR)
              .foregroundStyle(Alias.Color.Text.secondary)
          }
          Spacer()
        }

        Spacer(minLength: Alias.Spacing.xLarge)

        VStack(spacing: Alias.Spacing.small) {
          CatPushNotificationExampleView(selectedCat: $store.selectedCat)
          ZStack {
            Rectangle()
              .foregroundStyle(Alias.Color.Background.secondary)
              .frame(maxHeight: .infinity)
            store.catRiv.view()
          }

          Spacer()

          HStack {
            ForEach(store.catList) { cat in
              Button(
                title: LocalizedStringKey(cat.name),
                subtitle: LocalizedStringKey(cat.keyword),
                rightIcon: cat.keywordImage,
                action: { store.send(.selectCat(cat)) }
              )
              .buttonStyle(.select(isSelected: cat == store.selectedCat))
            }
          }
        }

        Spacer(minLength: Alias.Spacing.large)

        Button(title: "이 고양이와 함께하기") {
          store.send(.selectButtonTapped)
        }
        .buttonStyle(.box(level: .primary, size: .large, width: .low))
        .disabled(store.selectedCat == nil)
        .padding(.bottom, Alias.Spacing.small)
      }
      .padding(.horizontal, Alias.Spacing.xLarge)
    }
    .background {
      Alias.Color.Background.primary
        .ignoresSafeArea()
    }
    .navigationDestination(
      item: $store.scope(state: \.namingCat, action: \.namingCat)
    ) { store in
      NamingCatView(store: store)
    }
    .onAppear { store.send(.onAppear) }
  }
}

struct CatPushNotificationExampleView: View {
  @Binding var selectedCat: AnyCat?

  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: Alias.BorderRadius.xSmall,style: .circular)
        .foregroundStyle(Alias.Color.Background.secondary)

      if let selectedCat = selectedCat {
        HStack(spacing: 10){
          Image(systemName: "star.fill")
          VStack(spacing: 0) {
            HStack {
              Text("모하냥")
                .font(Typography.bodyR)
                .foregroundStyle(Alias.Color.Text.primary)
              Spacer()
              Text("지금")
                .font(Typography.subBodyR)
                .foregroundStyle(Alias.Color.Text.secondary)
            }
            HStack {
              Text(selectedCat.disturbPushTitle)
                .font(Typography.subBodyR)
                .foregroundStyle(Alias.Color.Text.primary)
              Spacer()
            }
          }
          Spacer()
        }
        .padding(.all, Alias.Spacing.medium)
      } else {
        Text("고양이를 선택하면\n딴 짓 방해알림 예시를 보여드려요")
          .font(Typography.bodyR)
          .foregroundStyle(Alias.Color.Text.tertiary)
          .multilineTextAlignment(.center)
          .padding(.all, Alias.Spacing.medium)
      }
    }
    .frame(height: 72)
  }
}
