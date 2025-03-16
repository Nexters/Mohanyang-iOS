//
//  CategoryFormCore.swift
//  HomeFeature
//
//  Created by 김지현 on 2/24/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//

import PomodoroServiceInterface

import ComposableArchitecture
import Foundation

@Reducer
public struct CategoryFormCore {
  @ObservableState
  public struct State: Equatable {
    var formType: FormType
    var isButtonDisabled: Bool = false
    var selectedIcon: PomodoroCategoryCode = .basic
    var text: String = ""
    var inputFieldError: CategoryNameError?

    @Presents var iconSelect: CategoryIconSelectCore.State?

    public init(type: FormType) {
      self.formType = type
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
  }

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
      return .none

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

    case .binding:
      return .none
    }
  }
}
