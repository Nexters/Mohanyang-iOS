//
//  DialogViewModifier.swift
//  DesignSystem
//
//  Created by 김지현 on 8/17/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

struct DialogView<T: Dialog>: View {
  let dialog: T
  var onDismiss: (() -> Void)?

  var body: some View {
    ZStack(alignment: .center) {
      Global.Color.black.opacity(Global.Opacity._50d)
        .ignoresSafeArea()
        .transition(.opacity)

      VStack(spacing: Alias.Spacing.large) {
        // MARK: Title & SubTitle 영역
        VStack(spacing: 0) {
          HStack(alignment: .center, spacing: 8) {
            Text(dialog.title)
              .font(Typography.header4)
              .foregroundStyle(Alias.Color.Text.primary)
              .lineLimit(1)
              .frame(maxWidth: .infinity, alignment: .leading)

            if dialog.showCloseButton {
              Button {
                onDismiss?()
              } label: {
                DesignSystemAsset.Image._24ClosePrimary.swiftUIImage
              }
              .buttonStyle(.icon(isFilled: false, level: .primary))
            }
          }
          .frame(minHeight: 40)

          if let subTitle = dialog.subTitle {
            Text(subTitle)
              .font(Typography.subBodyR)
              .foregroundStyle(Alias.Color.Text.secondary)
              .lineLimit(4)
              .frame(maxWidth: .infinity, alignment: .leading)
          }
        }

        // MARK: 버튼 영역
        HStack(spacing: Alias.Spacing.medium) {
          Button {
            Task {
              await dialog.firstButton.action?()
            }
            onDismiss?()
          } label: {
            Text(LocalizedStringKey(dialog.firstButton.title))
          }
          .buttonStyle(
            .box(
              level: dialog.firstButton.action == nil ? .tertiary : .primary,
              size: .medium,
              width: .low
            )
          )

          if let secondButton = dialog.secondButton {
            Button {
              Task {
                await secondButton.action?()
              }
              onDismiss?()
            } label: {
              Text(LocalizedStringKey(secondButton.title))
            }
            .buttonStyle(
              .box(
                level: secondButton.action == nil ? .tertiary : .primary,
                size: .medium,
                width: .low
              )
            )
          }
        }
      }
      .padding(Alias.Spacing.xLarge)
      .background(Global.Color.white)
      .cornerRadius(Alias.BorderRadius.medium)
      .padding(.horizontal, Alias.Spacing.xLarge)
      .transition(.scale)
    }
  }
}

extension View {
  public func dialog<T: Dialog>(dialog: Binding<T?>) -> some View {
    self
      .onChange(of: dialog.wrappedValue) { _, newValue in
        withAnimation {
          if let newDialog = newValue {
            let view = DialogView(
              dialog: newDialog,
              onDismiss: {
                dialog.wrappedValue = nil
              }
            )
            OverlayManager.shared.showOverlay(view)
          } else {
            OverlayManager.shared.hideOverlay()
          }
        }
      }
      .onAppear {
        if let newDialog = dialog.wrappedValue {
          let view = DialogView(
            dialog: newDialog,
            onDismiss: {
              dialog.wrappedValue = nil
            }
          )
          OverlayManager.shared.showOverlay(view)
        }
      }
  }
}
