//
//  CategorySelectView.swift
//  HomeFeature
//
//  Created by devMinseok on 8/13/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import DesignSystem

import ComposableArchitecture
import DatadogRUM

public struct CategorySelectView: View {
  @Namespace var moreButtonFrameID
  var moreButtonFrame: CGRect = .zero
  @Bindable var store: StoreOf<CategorySelectCore>
  
  public init(store: StoreOf<CategorySelectCore>) {
    self.store = store
  }
  
  public var body: some View {
    ZStack {
      VStack(spacing: Alias.Spacing.large) {
        HStack(spacing: .zero) {
          Text(store.selectType.title)
            .font(Typography.header3)
            .foregroundStyle(Alias.Color.Text.primary)
          Spacer()
          if store.selectType == .select {
            if store.isCategoryAddAvailable {
              Button(icon: DesignSystemAsset.Image._24PlusPrimary.swiftUIImage) {
                store.send(.addCategoryTapped)
              }
              .buttonStyle(.icon(isFilled: false, level: .primary))
            }

            Button(icon: DesignSystemAsset.Image._24EllipsisPrimary.swiftUIImage) {
              store.send(.moreButtonTapped)
            }
            .buttonStyle(.icon(isFilled: false, level: .primary))
            .padding(.leading, 8)
            .setFrameMeasure(space: .named("CategorySelectBottomSheet"), identifier: moreButtonFrameID)
            .getFrameMeasure { value in
              guard let frame = value[moreButtonFrameID] else { return }
              store.send(.setMoreButtonFrame(frame))
            }

          } else {
            Button(title: .init("취소")) {
              store.send(.cancelButtonTapped)
            }
            .buttonStyle(.text(level: .primary, size: .medium))
          }
        }
        .padding(.leading, Alias.Spacing.xLarge)
        .padding(.trailing, Alias.Spacing.small)
        .frame(height: 40)

        VStack(spacing: Alias.Spacing.small) {
          ForEach(store.categoryList) { category in
            Button(
              title: .init(category.title),
              subtitle: "집중 \(category.focusTimeMinutes)분 | 휴식 \(category.restTimeMinutes)분",
              leftIcon: category.baseCategoryCode.image
            ) {
              store.send(.selectCategory(category))
            }
            .buttonStyle(.selectList(isSelected: store.selectedCategory == category))
          }
        }
        .padding(.horizontal, Alias.Spacing.large)
        .padding(.bottom, Alias.Spacing.medium)
      }

      if store.isMenuViewShow {
        CategorySelectMenuView(
          position: store.moreButtonFrame,
          onEditTapped: { store.send(.editButtonTapped) },
          onDeleteTapped: { store.send(.deleteButtonTapped) }
        )
      }
    }
    .coordinateSpace(name: "CategorySelectBottomSheet")
    .onAppear {
      store.send(.onAppear)
    }
    .trackRUMView(name: "카테고리 변경")
  }
}
