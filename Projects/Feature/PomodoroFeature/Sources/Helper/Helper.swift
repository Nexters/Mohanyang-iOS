//
//  Helper.swift
//  PomodoroFeature
//
//  Created by devMinseok on 8/20/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

func formatTime(from seconds: Int) -> String {
  let minutes = seconds / 60
  let remainingSeconds = seconds % 60
  return String(format: "%02d:%02d", minutes, remainingSeconds)
}

func timeDifferenceInSeconds(from startDate: Date, to endDate: Date) -> Int {
  let difference = Int(endDate.timeIntervalSince(startDate))
  return difference
}
