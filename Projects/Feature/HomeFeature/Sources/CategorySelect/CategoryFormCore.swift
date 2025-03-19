//
//  CategoryFormCore.swift
//  HomeFeature
//
//  Created by 김지현 on 2/24/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//

import Foundation
import APIClientInterface
import PomodoroServiceInterface

import ComposableArchitecture

@Reducer
public struct CategoryFormCore {
  @ObservableState
  public struct State: Equatable {
    var formType: FormType
    var isButtonDisabled: Bool = false
    var selectedIcon: PomodoroIconType = .cat
    var text: String = ""
    var inputFieldError: CategoryNameError?

    @Presents var iconSelect: CategoryIconSelectCore.State?

    public init(type: FormType) {
      self.formType = type
      switch type {
      case .add:
        self.text = ""
        self.selectedIcon = .cat
      case .edit(let category):
        self.text = category.title
        self.selectedIcon = category.iconType
      }
    }
  }

  public enum Action: BindableAction {
    case binding(BindingAction<State>)

    case onAppear
    case bottomCheckButtonTapped

    case _addNewCategoryResponse(Result<Void, Error>)
    case _editCategoryResponse(Result<Void, Error>)

    case editIconTapped

    case iconSelect(PresentationAction<CategoryIconSelectCore.Action>)
  }

  public enum FormType: Equatable {
    case add, edit(PomodoroCategory)

    var title: String {
      switch self {
      case .add:
        return "카테고리 생성"
      case .edit:
        return "카테고리 수정"
      }
    }
  }

  @Dependency(APIClient.self) var apiClient
  @Dependency(PomodoroService.self) var pomodoroService

  public init() {}

  public var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce(self.core)
      .ifLet(\.$iconSelect, action: \.iconSelect) {
        CategoryIconSelectCore()
      }
  }

  private func core(state: inout State, action: Action) -> EffectOf<Self> {
    switch action {
    case .onAppear:
      return .none

    case .bottomCheckButtonTapped:
      return .run { [type = state.formType, title = state.text, iconType = state.selectedIcon.rawValue] send in
        switch type {
        case .add:
          try await self.pomodoroService.addCategory(
            apiClient: apiClient,
            request: .init(title: title, iconType: iconType)
          )
        case .edit(let category):
          try await self.pomodoroService.editCategory(
            apiClient: apiClient, categoryID: category.id,
            request: .init(title: title, iconType: iconType)
          )
        }
      }

    case ._addNewCategoryResponse(_):
      return .none

    case ._editCategoryResponse(_):
      return .none

    case .editIconTapped:
      state.iconSelect = CategoryIconSelectCore.State(selectedIcon: state.selectedIcon)
      return .none

    case .iconSelect(.presented(.selectIcon(let type))):
      state.selectedIcon = type
      state.iconSelect = nil
      return .none

    case .iconSelect:
      return .none

    case .binding(\.text):
      state.inputFieldError = state.text.count > 10 ? .exceedsMaxLength : nil
      state.isButtonDisabled = state.text.isEmpty ? true : false
      return .none

    case .binding:
      return .none
    }
  }
}
