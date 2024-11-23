//
//  RequestErrorView.swift
//  ErrorFeature
//
//  Created by 김지현 on 11/14/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import DesignSystem

public struct RequestErrorView: View {
  @Environment(\.dismiss) var dismiss

  public init() {

  }

  public var body: some View {
    HStack {
      Spacer()

      VStack(spacing: Alias.Spacing.xxxLarge) {
        Spacer()

        DesignSystemAsset.Image.error.swiftUIImage

        VStack(spacing: Alias.Spacing.small) {
          Text("문제가 발생했어요")
            .font(Typography.header4)
            .foregroundStyle(Alias.Color.Text.primary)
          Text("잠시 후에 다시 확인해주세요.\n문제가 지속된다면 고객센터에 문의해주세요.")
            .multilineTextAlignment(.center)
            .font(Typography.bodyR)
            .foregroundStyle(Alias.Color.Text.secondary)
        }
        .padding(.bottom, 34)

        VStack(spacing: Alias.Spacing.large) {
          Button(title: "홈으로 이동") {
            dismiss()
          }
          .buttonStyle(.box(level: .primary, size: .large, width: .medium))

          Button(
            action: {
              print("고객센터 문의")
            },
            label: {
              Text("고객센터 문의")
                .font(Typography.bodyR)
                .underline(pattern: .solid, color: Alias.Color.Text.tertiary)
                .foregroundStyle(Alias.Color.Text.tertiary)
            }
          )
        }

        Spacer()
      }

      Spacer()
    }
    .background(Alias.Color.Background.primary)
  }
}
