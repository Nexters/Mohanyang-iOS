//
//  WidgetExtensionBundle.swift
//  WidgetExtension
//
//  Created by devMinseok on 11/19/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import WidgetKit
import SwiftUI

import LAPomodoroFeature

@main
struct WidgetExtensionBundle: WidgetBundle {
  var body: some Widget {
    PomodoroLiveActivityWidget()
  }
}
