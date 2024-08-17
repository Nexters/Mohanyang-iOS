//
//  DialogViewModifier.swift
//  DesignSystem
//
//  Created by 김지현 on 8/17/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

public struct DialogButtonModel {
  let title: String
  let leftIcon: Image?
  let rightIcon: Image?
  let action: (() -> Void)? // 버튼 액션을 Nil로 두면 자동으로 CancelButton이 됩니다

  public init(title: String, leftIcon: Image? = nil, rightIcon: Image? = nil, action: (() -> Void)? = nil) {
    self.title = title
    self.leftIcon = leftIcon
    self.rightIcon = rightIcon
    self.action = action
  }
}

struct DialogViewModifier: ViewModifier {
  let title: String
  let subTitle: String?
  @Binding var isPresented: Bool
  let firstButton: DialogButtonModel
  let secondButton: DialogButtonModel?

  func body(content: Content) -> some View {
    ZStack(alignment: .center) {
      content
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .zIndex(1)

      if isPresented {
        Global.Color.black.opacity(Global.Opacity._50d)
          .ignoresSafeArea()
          .zIndex(2)


        // MARK: Title & SubTitle
        VStack(spacing: Alias.Spacing.large) {
          VStack(spacing: Alias.Spacing.small) {
            HStack {
              Text(title)
                .font(Typography.header4)
                .foregroundStyle(Alias.Color.Text.primary)
              Spacer()
              Button {
                self.isPresented = false
              } label: {
                DesignSystemAsset.Image._24CancelPrimary.swiftUIImage
              }
            }
            .padding(.top, Alias.Spacing.small)

            if let subTitle = subTitle {
              HStack {
                Text(subTitle)
                  .font(Typography.subBodyR)
                  .foregroundStyle(Alias.Color.Text.secondary)
                Spacer()
              }
            }
          }

          // MARK: Buttons
          HStack {
            Button(
              title: LocalizedStringKey(firstButton.title),
              leftIcon: firstButton.leftIcon,
              rightIcon: firstButton.rightIcon,
              action: {
                self.isPresented = false
                firstButton.action?()
              }
            )
            .buttonStyle(.box(level: firstButton.action == nil ? .tertiary : .primary, size: .medium, width: .low))
            if let secondButton = secondButton {
              Button(
                title: LocalizedStringKey(secondButton.title),
                leftIcon: secondButton.leftIcon,
                rightIcon: secondButton.rightIcon,
                action: {
                  self.isPresented = false
                  secondButton.action?()
                }
              )
              .buttonStyle(.box(level: secondButton.action == nil ? .tertiary : .primary, size: .medium, width: .low))
            }
          }
        }
        .padding(.all, Alias.Spacing.xLarge)
        .frame(width: 335)
        .background(Global.Color.white)
        .cornerRadius(Alias.BorderRadius.medium)
        .zIndex(3)
      }
    }
    .animation(.easeInOut(duration: 0.3), value: !self.isPresented)
  }
}

extension View {
  public func dialog(
    title: String,
    subTitle: String? = nil,
    isPresented: Binding<Bool>,
    firstButton: DialogButtonModel,
    secondButton: DialogButtonModel? = nil
  ) -> some View {
    return self.modifier(
      DialogViewModifier(
        title: title,
        subTitle: subTitle,
        isPresented: isPresented,
        firstButton: firstButton,
        secondButton: secondButton
      )
    )
  }
}
