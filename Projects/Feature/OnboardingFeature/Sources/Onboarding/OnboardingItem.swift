//
//  OnboardingItem.swift
//  OnboardingFeature
//
//  Created by 김지현 on 8/9/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation
import SwiftUI

import DesignSystem

struct OnboardingItem: Identifiable, Equatable {
  let id = UUID().uuidString
  let image: Image
  let title: String
  let subTitle: String
}

let OnboardingItemsData: [OnboardingItem] = [
  OnboardingItem(
    image: Image(systemName: "star"),
    title: "모하냥과 함께 집중시간을 늘려보세요",
    subTitle: "고양이 종에 따라 성격이 달라요.\n취향에 맞는 고양이를 선택해 몰입해 보세요."),
  OnboardingItem(
    image: Image(systemName: "star.fill"),
    title: "다른 앱을 실행하면 방해 알림을 보내요",
    subTitle: "뽀모도로를 실행한 후, 다른 앱을 사용하면\n설정한 주기로 방해 알림을 보내드려요."),
  OnboardingItem(
    image: Image(systemName: "home"),
    title: "다른 앱을 실행하면 방해 알림을 보내요",
    subTitle: "뽀모도로를 실행한 후, 다른 앱을 사용하면\n설정한 주기로 방해 알림을 보내드려요.")
]
