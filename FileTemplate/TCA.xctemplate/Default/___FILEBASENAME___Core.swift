//___FILEHEADER___

import ComposableArchitecture

@Reducer
struct ___VARIABLE_productName___Core {
  @ObservableState
  struct State: Equatable {
    <#properties#>
  }
  
  enum Action {
    <#case#>
  }
  
  <#@Dependency() var#>
  
  init() {}
  
  var body: some ReducerOf<Self> {
    Reduce(self.core)
  }
  
  private func core(state: inout State, action: Action) -> EffectOf<Self> {
    switch action {
    case <#pattern#>:
      <#code#>
    }
  }
}
