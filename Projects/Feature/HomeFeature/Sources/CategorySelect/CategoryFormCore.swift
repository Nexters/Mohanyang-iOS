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
    var isButtonDisabled: Bool = true
    var selectedIcon: PomodoroIconType = .cat
    var text: String = ""
    var inputFieldError: CategoryNameError?
    var focusedField: Field?

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
    case editIconTapped
    case categorySaved
    case setExistCategoryError(String)
    case setFocusedField(Field?)

    case _addNewCategoryResponse(Result<Void, Error>)
    case _editCategoryResponse(Result<Void, Error>)
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

  public enum Field {
    case nameTextField
  }

  @Dependency(APIClient.self) var apiClient
  @Dependency(PomodoroService.self) var pomodoroService
  let maxNameLength: Int = 10

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
      state.focusedField = .nameTextField
      return .none

    case .bottomCheckButtonTapped:
      let type = state.formType
      let title = state.text
      let iconType = state.selectedIcon.rawValue

      return .run { send in
        do {
          try await self.saveCategory(type: type, title: title, iconType: iconType, apiClient: apiClient)
          await send(.categorySaved)
        } catch let error as NetworkError {
          if case .apiError(let description) = error {
            await send(.setExistCategoryError(description))
          }
        }
      }

    case ._addNewCategoryResponse(_):
      return .none

    case ._editCategoryResponse(_):
      return .none

    case .editIconTapped:
      state.iconSelect = CategoryIconSelectCore.State(selectedIcon: state.selectedIcon)
      return .none

    case .setExistCategoryError(let msg):
      state.inputFieldError = .cantSetExistName(msg)
      state.isButtonDisabled = true
      return .none

    case .iconSelect(.presented(.selectIcon(let type))):
      state.selectedIcon = type
      state.iconSelect = nil
      return .none

    case .iconSelect:
      return .none

    case .categorySaved:
      return .none

    case let .setFocusedField(focusedField):
      state.focusedField = focusedField
      return .none

    case .binding(\.text):
      state.inputFieldError = state.text.count > maxNameLength ? .exceedsMaxLength(maxNameLength) : nil
      state.isButtonDisabled = state.text.isEmpty || state.inputFieldError != nil ? true : false
      return .none

    case .binding:
      return .none
    }
  }
}

extension CategoryFormCore {
  private func saveCategory(
    type: FormType,
    title: String,
    iconType: String,
    apiClient: APIClient
  ) async throws {
    switch type {
    case .add:
      let request = AddCategoryRequest(title: title, iconType: iconType)
      try await pomodoroService.addCategory(apiClient: apiClient, request: request)
    case .edit(let category):
      let request = EditCategoryRequest(title: title, iconType: iconType)
      try await pomodoroService.editCategory(apiClient: apiClient, categoryID: category.id, request: request)
    }
  }
}
