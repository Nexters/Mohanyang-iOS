//
//  OnboardingView.swift
//  OnboardingFeature
//
//  Created by 김지현 on 8/9/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI
import DesignSystem

import ComposableArchitecture

public struct OnboardingView: View {
  @Bindable var store: StoreOf<OnboardingCore>

  public init(store: StoreOf<OnboardingCore>) {
    self.store = store
  }

  public var body: some View {
    ZStack {
      Alias.Color.Background.primary
        .ignoresSafeArea()
      VStack {
        Spacer()
        VStack(spacing: 0) {
          TabView(selection: $store.currentItemID) {
            ForEach(store.fakedData, id: \.hashValue) { item in
              OnboardingCarouselContentView(width: $store.width, item: item)
                .tag(item.id.uuidString)
                .offsetX(store.currentItemID == item.id.uuidString) { minX in
                  store.send(.calculateOffset(minX, item))
                }
            }
          }
          .tabViewStyle(.page(indexDisplayMode: .never))
          .gesture(
            DragGesture()
              .onChanged { _ in store.send(.dragStart) }
              .onEnded { _ in store.send(.dragEnd) }
          )
          .frame(width: store.width, height: 350)

          HStack {
            ForEach(0..<3, id: \.self) { idx in
              Circle()
                .frame(width: 8, height: 8)
                .foregroundStyle(
                  idx == store.currentIdx ?
                  Alias.Color.Background.tertiary : Alias.Color.Background.secondary
                )
            }
          }
          .padding(.vertical, 32)

          Button(title: "시작하기") {
            // 다음 뷰 이동
          }
          .buttonStyle(.box(level: .primary, size: .large, width: .high))
          .padding(.top, 16)
        }
        Spacer()
      }
    }
    .onAppear { store.send(.onApear) }
    .background {
      GeometryReader { geometry in
        Color.clear
          .onAppear { store.width = geometry.size.width }
      }
    }
  }
}

struct OnboardingCarouselContentView: View {
  @Binding var width: CGFloat
  var item: OnboardingItem
  var body: some View {
    VStack(spacing: Alias.Spacing.xxxLarge) {
      ZStack {
        Rectangle()
          .foregroundStyle(Alias.Color.Background.secondary)
        Image(uiImage: item.image)
      }
      .frame(width: 240, height: 240)

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

struct OnboardingView_Previews: PreviewProvider {
  static var previews: some View {
    OnboardingView(store: Store(initialState: OnboardingCore.State()) { OnboardingCore() })
  }
}
