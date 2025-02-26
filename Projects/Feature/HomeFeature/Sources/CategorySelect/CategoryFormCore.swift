//
//  CategoryFormCore.swift
//  HomeFeature
//
//  Created by 김지현 on 2/24/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//

import PomodoroServiceInterface

import ComposableArchitecture

@Reducer
public struct CategoryFormCore {
  @ObservableState
  public struct State: Equatable {
    var formType: FormType
    var isButtonDisabled: Bool = false
    var selectedCategory: PomodoroCategory?
    var text: String = ""
    var inputFieldError: CategoryNameError?
    var selectedIcon: String?

    public init(type: FormType) {
      self.formType = type
    }
  }

  public enum Action: BindableAction {
    case onAppear
    case bottomCheckButtonTapped

    case _addNewCategoryResponse(Result<Void, Error>)
    case _editCategoryResponse(Result<Void, Error>)

    case selectIcon(String)

    case binding(BindingAction<State>)
  }

  public enum FormType {
    case add, edit
  }

  @Dependency(PomodoroService.self) var pomodoroService

  public init() {}

  public var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce(self.core)
  }

  private func core(state: inout State, action: Action) -> EffectOf<Self> {
    switch action {
    case .onAppear:
      return .none

    case .bottomCheckButtonTapped:
      return .none

    case ._addNewCategoryResponse(_):
      return .none

    case ._editCategoryResponse(_):
      return .none

    case .selectIcon(_):
      return .none

    case .binding:
      return .none
    }
  }
}
