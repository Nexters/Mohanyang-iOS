//
//  DialogViewModifier.swift
//  DesignSystem
//
//  Created by 김지현 on 8/17/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

struct DialogViewModifier<T: Dialog>: ViewModifier {
  @Binding var dialog: T?

  func body(content: Content) -> some View {
    ZStack(alignment: .center) {
      content
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .zIndex(1)

      if let dialog {
        Global.Color.black.opacity(Global.Opacity._50d)
          .ignoresSafeArea()
          .zIndex(2)


        // MARK: Title & SubTitle
        VStack(spacing: Alias.Spacing.large) {
          VStack(spacing: Alias.Spacing.small) {
            HStack {
              Text(dialog.title)
                .font(Typography.header4)
                .foregroundStyle(Alias.Color.Text.primary)
              Spacer()
              Button {
                self.dialog = nil
              } label: {
                DesignSystemAsset.Image._24CancelPrimary.swiftUIImage
              }
            }
            .padding(.top, Alias.Spacing.small)

            if let subTitle = dialog.subTitle {
              HStack {
                Text(subTitle)
                  .font(Typography.subBodyR)
                  .foregroundStyle(Alias.Color.Text.secondary)
                Spacer()
              }
            }
          }

          // MARK: Buttons
          HStack(spacing: 12) {
            Button(
              title: LocalizedStringKey(dialog.firstButton.title),
              leftIcon: dialog.firstButton.leftIcon,
              rightIcon: dialog.firstButton.rightIcon,
              action: {
                self.dialog = nil
                dialog.firstButton.action?()
              }
            )
            .buttonStyle(.box(level: dialog.firstButton.action == nil ? .tertiary : .primary, size: .medium, width: .low))
            if let secondButton = dialog.secondButton {
              Button(
                title: LocalizedStringKey(secondButton.title),
                leftIcon: secondButton.leftIcon,
                rightIcon: secondButton.rightIcon,
                action: {
                  self.dialog = nil
                  secondButton.action?()
                }
              )
              .buttonStyle(.box(level: secondButton.action == nil ? .tertiary : .primary, size: .medium, width: .low))
            }
          }
        }
        .padding(.all, Alias.Spacing.xLarge)
        .background(Global.Color.white)
        .cornerRadius(Alias.BorderRadius.medium)
        .padding(.horizontal, Alias.Spacing.xLarge)
        .zIndex(3)
      }
    }
    .ignoresSafeArea()
    .animation(.easeInOut(duration: 0.3), value: self.dialog == nil)
  }
}

extension View {
  public func dialog<T: Dialog>(
    dialog: Binding<T?>
  ) -> some View {
    return self.modifier(DialogViewModifier(dialog: dialog))
  }
}