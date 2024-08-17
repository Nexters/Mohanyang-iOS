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
  @State var titleSubTitleTwoButtonDialogIsPresented: Bool = false
  @State var titleSubTitleOneButtonDialogIsPresented: Bool = false
  @State var titleTwoButtonDialogIsPresented: Bool = false
  @State var titleOneButtonDialogIsPresented: Bool = false

  var body: some View {
    VStack(spacing: 10) {
      Spacer()

      Button {
        titleSubTitleTwoButtonDialogIsPresented = true
      } label: {
        Text("title SubTitle & Two Button")
      }

      Button {
        titleSubTitleOneButtonDialogIsPresented = true
      } label: {
        Text("title SubTitle & One Button")
      }

      Button {
        titleTwoButtonDialogIsPresented = true
      } label: {
        Text("title & Two Button")
      }

      Button {
        titleOneButtonDialogIsPresented = true
      } label: {
        Text("title & One Button")
      }

      Spacer()
    }
    .dialog(
      title: "Dialog Title",
      subTitle: "Dialog Subtext를 입력해주세요.\n최대 2줄을 넘지 않도록 해요.",
      isPresented: $titleSubTitleTwoButtonDialogIsPresented,
      firstButton: DialogButtonModel(title: "Button1"),
      secondButton: DialogButtonModel(title: "Button2", action: { print(" PRINT !!") })
    )
    .dialog(
      title: "Dialog Title",
      subTitle: "Dialog Subtext를 입력해주세요.\n최대 2줄을 넘지 않도록 해요.",
      isPresented: $titleSubTitleOneButtonDialogIsPresented,
      firstButton: DialogButtonModel(title: "Button1")
    )
    .dialog(
      title: "Dialog Title",
      isPresented: $titleTwoButtonDialogIsPresented,
      firstButton: DialogButtonModel(title: "Button1"),
      secondButton: DialogButtonModel(title: "Button2", action: { print(" PRINT !!") })
    )
    .dialog(
      title: "Dialog Title",
      isPresented: $titleOneButtonDialogIsPresented,
      firstButton: DialogButtonModel(title: "Button1")
    )
  }
}
