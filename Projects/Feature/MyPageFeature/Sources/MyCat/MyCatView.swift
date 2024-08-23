//
//  MyCatView.swift
//  MyPageFeature
//
//  Created by 김지현 on 8/19/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import CatFeature
import DesignSystem

import ComposableArchitecture

public struct MyCatView: View {
  @Bindable var store: StoreOf<MyCatCore>
  
  public init(store: StoreOf<MyCatCore>) {
    self.store = store
  }
  
  public var body: some View {
    NavigationContainer(
      title: Text("나의 고양이"),
      style: .navigation
    ) {
      VStack {
        Spacer()
        VStack(spacing: Alias.Spacing.medium) {
          store.catRiv.view()
          .setTooltipTarget(tooltip: MyCatTooltip.self)
          .frame(height: 240)

          HStack(spacing: Alias.Spacing.xSmall) {
            Text(store.cat?.baseInfo.name ?? "")
              .font(Typography.header4)
              .foregroundStyle(Alias.Color.Text.secondary)
            DesignSystemAsset.Image._24PenPrimary.swiftUIImage
          }
          .onTapGesture {
            store.send(.changeCatNameButtonTapped)
          }
        }
        Spacer()

        Button(title: "고양이 바꾸기") {
          store.send(.changeCatButtonTapped)
        }
        .buttonStyle(.box(level: .secondary, size: .large, width: .low))
        .padding(.bottom, Alias.Spacing.small)
      }
      .padding(.horizontal, Alias.Spacing.xLarge)
    }
    .background(Alias.Color.Background.primary)
    .tooltipDestination(tooltip: $store.tooltip.sending(\.setTooltip))
    .navigationDestination(
      item: $store.scope(state: \.selectCat, action: \.selectCat)
    ) { store in
      SelectCatView(store: store)
    }
    .navigationDestination(
      item: $store.scope(state: \.namingCat, action: \.namingCat)
    ) { store in
      NamingCatView(store: store)
    }
    .onAppear {
      store.send(.onAppear)
    }
  }
}
