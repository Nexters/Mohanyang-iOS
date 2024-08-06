//
//  FontDetailView.swift
//  DesignSystem
//
//  Created by devMinseok on 8/6/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import DesignSystem

struct FontDetailView: View {
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text("Time")
        .font(Typography.time)
      Text("Header1")
        .font(Typography.header1)
      Text("Header2")
        .font(Typography.header2)
      Text("Header3")
        .font(Typography.header3)
      Text("Header4")
        .font(Typography.header4)
      Text("Header5")
        .font(Typography.header5)
      Text("Body_SB")
        .font(Typography.bodySB)
      Text("Body_R")
        .font(Typography.bodyR)
      Text("SubBody_SB")
        .font(Typography.subBodySB)
      Text("SubBody_R")
        .font(Typography.subBodyR)
      Text("Caption_SB")
        .font(Typography.captionSB)
      Text("Caption_R")
        .font(Typography.captionR)
    }
  }
}
