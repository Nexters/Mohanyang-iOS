//
//  OnboardingItem.swift
//  OnboardingFeature
//
//  Created by 김지현 on 8/9/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import DesignSystem

public struct OnboardingItem: Equatable, Identifiable {
  public var id: UUID = .init()
  let image: Image
  var title: String
  let subTitle: String
}

let OnboardingItemsData: [OnboardingItem] = [
  OnboardingItem(
    image: DesignSystemAsset.Image.imgOnboarding1.swiftUIImage,
    title: "모하냥과 함께 집중시간을 늘려보세요",
    subTitle: "고양이 종에 따라 성격이 달라요.\n취향에 맞는 고양이를 선택해 몰입해 보세요."),
  OnboardingItem(
    image: DesignSystemAsset.Image.imgOnboarding2.swiftUIImage,
    title: "다른 앱을 실행하면 방해 알림을 보내요",
    subTitle: "뽀모도로를 실행한 후, 다른 앱을 사용하면\n설정한 주기로 방해 알림을 보내드려요."),
  OnboardingItem(
    image: DesignSystemAsset.Image.imgOnboarding3.swiftUIImage,
    title: "집중과 휴식 반복을 통해 몰입을 관리해요",
    subTitle: "일정 시간 집중과 휴식을 반복해 번아웃을 방지하고\n짧은 시간의 몰입을 경험해보세요.")
]

