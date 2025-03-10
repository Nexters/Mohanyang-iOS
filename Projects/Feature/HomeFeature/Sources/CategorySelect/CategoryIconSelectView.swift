//
//  CategoryIconSelectView.swift
//  HomeFeature
//
//  Created by 김지현 on 3/2/25.
//  Copyright 2025 PomoNyang. All rights reserved.
//

import SwiftUI
import PomodoroServiceInterface
import DesignSystem

import ComposableArchitecture

public struct CategoryIconSelectView: View {
  var store: StoreOf<CategoryIconSelectCore>

  public init(store: StoreOf<CategoryIconSelectCore>) {
    self.store = store
  }

  private let columns = Array(repeating: GridItem(.flexible(), spacing: 30), count: 4)

  public var body: some View {
    LazyVGrid(columns: columns, spacing: 8) {
      ForEach(PomodoroCategoryCode.allCases, id: \.self) { type in
        CategoryIconItem(
          categoryType: type,
          isSelected: store.selectedIcon == type
        )
        .onTapGesture {
          store.send(.selectIcon(type))
        }
      }
    }
    .padding(20)
  }
}

private struct CategoryIconItem: View {
  let categoryType: PomodoroCategoryCode
  let isSelected: Bool

  var body: some View {
    categoryType.image
      .padding(12)
      .frame(width: 56, height: 56)
      .background(
        RoundedRectangle(cornerRadius: 12)
          .stroke(isSelected ? Alias.Color.Background.accent1 : .clear)
      )
  }
}
