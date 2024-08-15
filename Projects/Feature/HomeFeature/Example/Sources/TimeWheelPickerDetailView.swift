//
//  TimeWheelPickerDetailView.swift
//  DesignSystemExample
//
//  Created by devMinseok on 8/13/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import HomeFeature

#Preview {
  TimeSelectView(
    store: .init(
      initialState: .init(),
      reducer: { TimeSelectCore() }
    )
  )
}
