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

  private var columns: [GridItem] {
    let columnCount = store.categoryList.count > 1 ? 2 : 1
    return Array(
      repeating: GridItem(.flexible(), spacing: Alias.Spacing.small),
      count: columnCount
    )
  }

  public init(store: StoreOf<CategorySelectCore>) {
    self.store = store
  }

  public var body: some View {
    VStack(spacing: Alias.Spacing.large) {
      HStack(alignment: .top, spacing: .zero) {
        VStack(alignment: .leading, spacing: 10) {
          Text(store.selectType.title)
            .font(Typography.header3)
            .foregroundStyle(Alias.Color.Text.primary)
          if let desc = store.selectType.desc {
            Text(desc)
              .font(Typography.bodyR)
              .foregroundStyle(Alias.Color.Text.secondary)
          }
        }
        Spacer()
        if store.selectType == .select {
          if store.isCategoryAddAvailable {
            Button(icon: DesignSystemAsset.Image._24PlusPrimary.swiftUIImage) {
              store.send(.addCategoryTapped)
            }
            .buttonStyle(.icon(isFilled: false, level: .primary))
          }

          Button(icon: DesignSystemAsset.Image._24EllipsisPrimary.swiftUIImage) {
            store.send(.showMenu(true))
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

      LazyVGrid(columns: columns, spacing: Alias.Spacing.small) {
        ForEach(store.categoryList) { category in
          Button(
            title: .init(category.title),
            subtitle: nil,
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
    .coordinateSpace(name: "CategorySelectBottomSheet")
    .overlay {
      if store.isMenuViewShow {
        Color.clear
          .contentShape(Rectangle())
          .onTapGesture {
            store.send(.showMenu(false))
          }
          .overlay(alignment: .topTrailing) {
            CategorySelectMenuView(
              position: store.moreButtonFrame,
              onEditTapped: { store.send(.editButtonTapped) },
              onDeleteTapped: { store.send(.deleteButtonTapped) }
            )
          }
      }
    }
    .onAppear {
      store.send(.onAppear)
    }
    .trackRUMView(name: "카테고리 변경")
  }
}
