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
import DatadogRUM

public struct MyPageView: View {
  @Environment(\.scenePhase) private var scenePhase
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
          MyCatSectionView(
            name: store.cat?.baseInfo.name ?? "",
            isNetworkConntected: $store.isNetworkConnected
          )
          .padding(.all, Alias.Spacing.xLarge)
          .background(
            RoundedRectangle(cornerRadius: Alias.BorderRadius.small)
              .foregroundStyle(Alias.Color.Background.secondary)
          )
          .onTapGesture {
            if store.isNetworkConnected {
              store.send(.myCatDetailTapped)
            }
          }

          StatisticSectionView(isNetworkConnected: $store.isNetworkConnected)

          VStack(spacing: Alias.Spacing.large) {
            AlarmSectionView(
              title: "집중시간 알림받기",
              subTitle: "집중・휴식시간이 되면 고양이가 알려줘요",
              isOn: $store.isTimerAlarmOn.sending(\.timerAlarmToggleButtonTapped)
            )
            AlarmSectionView(
              title: "딴 짓 방해하기",
              subTitle: "다른 앱을 사용하면 고양이가 방해해요",
              isOn: $store.isDisturbAlarmOn.sending(\.disturbAlarmToggleButtonTapped)
            )
            AlarmSectionView(
              title: "잠금화면 표시하기",
              subTitle: "잠금화면에 집중•휴식시간을 표시해요",
              isOn: $store.isLiveActivityOn.sending(\.liveActivityToggleButtonTapped)
            )
          }
          .padding(.all, Alias.Spacing.xLarge)
          .background(
            RoundedRectangle(cornerRadius: Alias.BorderRadius.small)
              .foregroundStyle(Alias.Color.Background.secondary)
          )

          HStack(spacing: .zero) {
            Text("의견 보내기")
              .font(Typography.bodySB)
              .foregroundStyle(Alias.Color.Text.primary)
            Spacer()
            DesignSystemAsset.Image._24ChevronRightPrimary.swiftUIImage
          }
          .padding(.all, Alias.Spacing.xLarge)
          .background(
            RoundedRectangle(cornerRadius: Alias.BorderRadius.small)
              .foregroundStyle(Alias.Color.Background.secondary)
          )
          .onTapGesture {
            store.send(.sendFeedbackButtonTapped)
          }
        }
        .padding(.horizontal, Alias.Spacing.xLarge)

        Spacer(minLength: Alias.Spacing.xxxLarge)
      }
      .scrollIndicators(.never)
    }
    .background(Alias.Color.Background.primary)
    .dialog(dialog: $store.dialog)
    .navigationDestination(
      item: $store.scope(state: \.myCat, action: \.myCat)
    ) { store in
      MyCatView(store: store)
    }
    .task {
      await store.send(.task).finish()
    }
    .onChange(of: scenePhase) {
      if scenePhase == .active {
        store.send(.scenePhaseActive)
      }
    }
    .onAppear {
      store.send(.onAppear)
    }
    .trackRUMView(name: "마이페이지")
  }
}

struct MyCatSectionView: View {
  let name: String
  @Binding var isNetworkConntected: Bool

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
      if isNetworkConntected {
        DesignSystemAsset.Image._24ChevronRightPrimary.swiftUIImage
      }
    }
  }
}

struct StatisticSectionView: View {
  @Binding var isNetworkConnected: Bool

  var body: some View {
    VStack(spacing: Alias.Spacing.large) {
      if isNetworkConnected {
        content(
          image: DesignSystemAsset.Image.imgUpdateStatistics.swiftUIImage,
          title: "통계 기능을 준비하고 있어요",
          subTitle: "집중시간을 모아보는 통계가\n곧업데이트될 예정이에요"
        )
      } else {
        content(
          image: DesignSystemAsset.Image.imgOfflineStatistics.swiftUIImage,
          title: "지금은 통계를 확인할 수 없어요",
          subTitle: "인터넷에 연결하면 통계를 볼 수 있어요"
        )
      }
    }
    .frame(maxWidth: .infinity)
    .padding(.all, Alias.Spacing.xxLarge)
    .background(
      RoundedRectangle(cornerRadius: Alias.BorderRadius.medium)
        .foregroundStyle(Alias.Color.Background.secondary)
    )
  }

  @ViewBuilder private func content(image: Image, title: String, subTitle: String) -> some View {
    image.resizable()
      .frame(width: 96, height: 96)

    VStack(spacing: Alias.Spacing.xSmall) {
      Text(title)
        .font(Typography.bodySB)
        .foregroundStyle(Alias.Color.Text.secondary)
      Text(subTitle)
        .font(Typography.subBodyR)
        .foregroundStyle(Alias.Color.Text.secondary)
        .multilineTextAlignment(.center)
    }
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
