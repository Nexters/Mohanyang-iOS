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

public struct OnboardingItem: Hashable, Identifiable {
  public var id: UUID = .init()
  let image: UIImage
  let title: String
  let subTitle: String
}

func getIndex(
  item: OnboardingItem
) -> Int {
  let index = OnboardingItemsData.firstIndex { currentItem in
    return currentItem.title == item.title
  } ?? 0
  return index
}

let OnboardingItemsData: [OnboardingItem] = [
  OnboardingItem(
    image: UIImage(systemName: "star")!,
    title: "모하냥과 함께 집중시간을 늘려보세요",
    subTitle: "고양이 종에 따라 성격이 달라요.\n취향에 맞는 고양이를 선택해 몰입해 보세요."),
  OnboardingItem(
    image: UIImage(systemName: "star.fill")!,
    title: "다른 앱을 실행하면 방해 알림을 보내요",
    subTitle: "뽀모도로를 실행한 후, 다른 앱을 사용하면\n설정한 주기로 방해 알림을 보내드려요."),
  OnboardingItem(
    image: UIImage(systemName: "house")!,
    title: "집중과 휴식 반복을 통해 몰입을 관리해요",
    subTitle: "일정 시간 집중과 휴식을 반복해 번아웃을 방지하고\n짧은 시간의 몰입을 경험해보세요.")
]

public struct RandomAccessEquatableItems<Element>: RandomAccessCollection, Equatable where Element: Equatable {
  var elements: [Element]
  public init(elements: [Element]) {
    self.elements = elements
  }

  public var startIndex: Int { elements.startIndex }
  public var endIndex: Int { elements.endIndex }

  public subscript(position: Int) -> Element {
    return elements[position]
  }

  public static func == (lhs: RandomAccessEquatableItems, rhs: RandomAccessEquatableItems) -> Bool {
    guard lhs.count == rhs.count else { return false }
    for (index, element) in lhs.enumerated() {
      if element != rhs[index] {
        return false
      }
    }
    return true
  }
}

