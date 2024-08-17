//
//  DialogDetailView.swift
//  DesignSystem
//
//  Created by 김지현 on 8/17/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import DesignSystem

struct DialogDetailView: View {
  @State var titleSubTitleTwoButtonDialog: DefaultDialog?
  @State var titleSubTitleOneButtonDialog: DefaultDialog?
  @State var titleTwoButtonDialog: DefaultDialog?
  @State var titleOneButtonDialog: DefaultDialog?

  var body: some View {
    VStack(spacing: 10) {
      Spacer()

      Button {
        titleSubTitleTwoButtonDialog = DefaultDialog(
          title: "Dialog Title",
          subTitle: "Dialog Subtext를 입력해주세요.\n최대 2줄을 넘지 않도록 해요.",
          firstButton: DialogButtonModel(title: "Button1"),
          secondButton: DialogButtonModel(title: "Button2", action: { print(" PRINT !!") })
        )
      } label: {
        Text("title SubTitle & Two Button")
      }

      Button {
        titleSubTitleOneButtonDialog = DefaultDialog(
          title: "Dialog Title",
          subTitle: "Dialog Subtext를 입력해주세요.\n최대 2줄을 넘지 않도록 해요.",
          firstButton: DialogButtonModel(title: "Button1")
        )
      } label: {
        Text("title SubTitle & One Button")
      }

      Button {
        titleTwoButtonDialog = DefaultDialog(
          title: "Dialog Title",
          firstButton: DialogButtonModel(title: "Button1"),
          secondButton: DialogButtonModel(title: "Button2", action: { print(" PRINT !!") })
        )
      } label: {
        Text("title & Two Button")
      }

      Button {
        titleOneButtonDialog = DefaultDialog(
          title: "Dialog Title",
          firstButton: DialogButtonModel(title: "Button1")
        )
      } label: {
        Text("title & One Button")
      }

      Spacer()
    }
    .dialog(dialog: $titleSubTitleTwoButtonDialog)
    .dialog(dialog: $titleSubTitleOneButtonDialog)
    .dialog(dialog: $titleTwoButtonDialog)
    .dialog(dialog: $titleOneButtonDialog)
  }
}
