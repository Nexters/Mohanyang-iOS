//
//  MyPageView.swift
//  MyPageFeature
//
//  Created by 김지현 on 8/19/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

import DesignSystem

import ComposableArchitecture

public struct MyPageView: View {
  @Bindable var store: StoreOf<MyPageCore>
  
  public init(store: StoreOf<MyPageCore>) {
    self.store = store
  }
  
  public var body: some View {
    NavigationContainer(
      title: Text("마이페이지"),
      style: .navigation
    ) {
      ScrollView {
        VStack(spacing: Alias.Spacing.medium) {

          MyCatSectionView(name: store.cat?.name ?? "")
            .padding(.all, Alias.Spacing.xLarge)
            .background(
              RoundedRectangle(cornerRadius: Alias.BorderRadius.small)
                .foregroundStyle(Alias.Color.Background.secondary)
            )
            .onTapGesture {
              store.send(.myCatDetailTapped)
            }

          StatisticSectionView(isInternetConnected: $store.isInternetConnected)
            .padding(.all, Alias.Spacing.xLarge)
            .background(
              RoundedRectangle(cornerRadius: Alias.BorderRadius.medium)
                .foregroundStyle(Alias.Color.Background.secondary)
            )

          VStack(spacing: Alias.Spacing.large) {
            AlarmSectionView(
              title: "집중시간 알림받기",
              subTitle: "집중・휴식시간이 되면 고양이가 알려줘요",
              isOn: $store.isFocusTimeAlarmOn
            )
            AlarmSectionView(
              title: "딴 짓 방해하기",
              subTitle: "다른 앱을 사용하면 고양이가 방해해요",
              isOn: $store.isDisturbAlarmOn
            )
          }
          .padding(.all, Alias.Spacing.xLarge)
          .background(
            RoundedRectangle(cornerRadius: Alias.BorderRadius.small)
              .foregroundStyle(Alias.Color.Background.secondary)
          )

          HStack {
            Text("의견 보내기")
            Spacer()
            DesignSystemAsset.Image._24ChevronRightPrimary.swiftUIImage
          }
          .padding(.all, Alias.Spacing.xLarge)
          .background(
            RoundedRectangle(cornerRadius: Alias.BorderRadius.small)
              .foregroundStyle(Alias.Color.Background.secondary)
          )
          .onTapGesture {
            openFeedbackForm(urlString: store.feedbackURLString)
          }

        }
        .padding(.horizontal, Alias.Spacing.xLarge)

        Spacer(minLength: Alias.Spacing.xxxLarge)
      }
      .scrollIndicators(.never)
    }
    .background(Alias.Color.Background.primary)
    .navigationDestination(
      item: $store.scope(state: \.myCat, action: \.myCat)
    ) { store in
      MyCatView(store: store)
    }
    .onAppear {
      store.send(.onAppear)
    }
  }

  private func openFeedbackForm(urlString: String) {
    if let url = URL(string: urlString) {
      UIApplication.shared.open(url)
    }
  }
}

struct MyCatSectionView: View {
  let name: String

  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: Alias.Spacing.xSmall) {
        Text("나의 고양이")
          .font(Typography.subBodyR)
          .foregroundStyle(Alias.Color.Text.tertiary)
        Text(name)
          .font(Typography.header4)
          .foregroundStyle(Color.black)
      }
      Spacer()
      DesignSystemAsset.Image._24ChevronRightPrimary.swiftUIImage
    }
  }
}

struct StatisticSectionView: View {
  @Binding var isInternetConnected: Bool

  var body: some View {
    ZStack {
      VStack(spacing: Alias.Spacing.medium) {
        Spacer()
        if isInternetConnected {
          DesignSystemAsset.Image.imgUpdateStatistics.swiftUIImage
        } else {
          DesignSystemAsset.Image.imgOfflineStatistics.swiftUIImage
        }
        VStack(spacing: Alias.Spacing.xSmall) {
          Text("통계 기능을 준비하고 있어요")
            .font(Typography.header4)
            .foregroundStyle(Alias.Color.Text.primary)
          Text("집중시간을 모아보는 통계가\n곧업데이트될 예정이에요")
            .font(Typography.subBodyR)
            .foregroundStyle(Alias.Color.Text.secondary)
            .multilineTextAlignment(.center)
        }
        Spacer()
      }
    }
    .frame(maxWidth: .infinity)
    .frame(minHeight: 375)
  }
}

struct AlarmSectionView: View {
  let title: String
  let subTitle: String
  @Binding var isOn: Bool
  
  var body: some View {
    HStack(spacing: 0) {
      VStack(alignment: .leading, spacing: Alias.Spacing.xSmall) {
        Text(title)
          .font(Typography.bodySB)
          .foregroundStyle(Alias.Color.Text.primary)
        Text(subTitle)
          .font(Typography.subBodyR)
          .foregroundStyle(Alias.Color.Text.tertiary)
          .lineLimit(1)
      }

      Spacer()

      Toggle("", isOn: $isOn)
        .labelsHidden()
        .tint(Alias.Color.Background.accent1)
    }
  }
}
