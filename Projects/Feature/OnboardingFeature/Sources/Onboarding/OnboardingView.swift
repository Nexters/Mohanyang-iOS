//
//  OnboardingView.swift
//  OnboardingFeature
//
//  Created by 김지현 on 8/9/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import CatFeature
import DesignSystem

import ComposableArchitecture
import DatadogRUM

public struct OnboardingView: View {
  @Namespace var backgroundFrame
  @Bindable var store: StoreOf<OnboardingCore>
  
  public init(store: StoreOf<OnboardingCore>) {
    self.store = store
  }
  
  public var body: some View {
    NavigationContainer(
      leading: { Spacer() },
      style: .navigation
    ) {
      VStack(spacing: 48) {
        VStack(spacing: Alias.Spacing.xxxLarge) {
          TabView(selection: $store.currentItemID) {
            ForEach(store.fakedData) { item in
              OnboardingCarouselContentView(width: $store.width, item: item)
                .tag(item.id.uuidString)
                .offsetX(store.currentItemID == item.id.uuidString) { minX in
                  store.send(.calculateOffset(minX, item))
                }
            }
          }
          .tabViewStyle(.page(indexDisplayMode: .never))
          .frame(width: store.width, height: 350)
          .gesture(
            DragGesture()
              .onChanged { _ in store.send(.dragStart) }
          )
          
          HStack(spacing: 8) {
            ForEach(0..<store.data.count, id: \.self) { idx in
              Circle()
                .frame(width: 8, height: 8)
                .foregroundStyle(
                  idx == store.currentIdx ?
                  Alias.Color.Background.tertiary : Alias.Color.Background.secondary
                )
            }
          }
        }
        
        Button(title: "시작하기") {
          store.send(.tapStartButton)
        }
        .buttonStyle(.box(level: .primary, size: .large, width: .medium))
      }
    }
    .background(Alias.Color.Background.primary)
    .setFrameMeasure(space: .global, identifier: backgroundFrame)
    .getFrameMeasure { value in
      /* TODO: 11.25
       Onboarding 재 초기화 시 FrameMeasure 관련 모디파이어를 안거침 . ,, 파악중
       getFrameMeasure -> OnDisappear 시에도 거치는 이유는 ?
      */
      guard let background = value[backgroundFrame] else { return }
      store.width = background.width
    }
    .navigationDestination(
      item: $store.scope(state: \.selectCat, action: \.selectCat)
    ) { store in
      SelectCatView(store: store)
    }
    .onLoad {
      store.send(.onLoad)
    }
    .trackRUMView(name: "온보딩")
  }
}

struct OnboardingCarouselContentView: View {
  @Binding var width: CGFloat
  var item: OnboardingItem
  var body: some View {
    VStack(spacing: Alias.Spacing.xxxLarge) {
      item.image

      VStack(spacing: Alias.Spacing.small) {
        Text(item.title)
          .font(Typography.header4)
          .foregroundStyle(Alias.Color.Text.primary)
        Text(item.subTitle)
          .font(Typography.bodyR)
          .foregroundStyle(Alias.Color.Text.secondary)
      }
      .multilineTextAlignment(.center)
    }
    .frame(width: width, height: 350)
  }
}
