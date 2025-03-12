//
//  CategorySelectMenuView.swift
//  HomeFeature
//
//  Created by 김지현 on 3/12/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//

import SwiftUI
import DesignSystem

public struct CategorySelectMenuView: View {
  var position: CGRect
  let onEditTapped: () -> Void
  let onDeleteTapped: () -> Void

  public var body: some View {
    VStack(spacing: 0) {
      Button {
        onEditTapped()
      } label: {
        HStack(spacing: Alias.Spacing.small) {
          DesignSystemAsset.Image._24PenPrimary.swiftUIImage
          Text("수정")
            .font(Typography.bodySB)
            .foregroundStyle(Alias.Color.Text.secondary)
        }
        .padding(.trailing, Alias.Spacing.large)
        .padding(.leading, Alias.Spacing.medium)
        .padding(.vertical, 9)
      }

      Button {
        onDeleteTapped()
      } label: {
        HStack(spacing: Alias.Spacing.small) {
          DesignSystemAsset.Image._24PenPrimary.swiftUIImage
          Text("삭제")
            .font(Typography.bodySB)
            .foregroundStyle(Alias.Color.Text.secondary)
        }
        .padding(.trailing, Alias.Spacing.large)
        .padding(.leading, Alias.Spacing.medium)
        .padding(.vertical, 9)
      }
    }
    .padding(.horizontal, Alias.Spacing.small)
    .padding(.vertical, Alias.Spacing.medium)
    .background(Global.Color.white)
    .frame(width: 104, height: 104)
    .cornerRadius(Alias.BorderRadius.small)
    .shadow(color: .black.opacity(0.12), radius: 4, x: 0, y: 2)
    .position(x: position.maxX - 104 / 2, y: position.maxY + 104 / 2)
  }
}

