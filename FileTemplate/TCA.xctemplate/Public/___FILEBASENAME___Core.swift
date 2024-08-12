//___FILEHEADER___

import ComposableArchitecture

@Reducer
public struct ___VARIABLE_productName___Core {
  @ObservableState
  public struct State: Equatable {
    <#properties#>
  }
  
  public enum Action {
    <#case#>
  }
  
  <#@Dependency() var#>
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
    Reduce(self.core)
  }
  
  private func core(state: inout State, action: Action) -> EffectOf<Self> {
    switch action {
    case <#pattern#>:
      <#code#>
    }
  }
}
