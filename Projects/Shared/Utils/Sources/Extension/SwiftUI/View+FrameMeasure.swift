//
//  FrameMeasure.swift
//  DesignSystem
//
//  Created by devMinseok on 8/15/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

public struct FrameMeasurePreferenceKey: PreferenceKey {
  public typealias Value = [AnyHashable: CGRect]
  
  public static var defaultValue: Value = Value()
  
  public static func reduce(value: inout Value, nextValue: () -> Value) {
    value.merge(nextValue()) { _, new in
      new
    }
  }
}

private struct FrameMeasureGeometry: View {
  let space: CoordinateSpace
  let identifier: AnyHashable
  
  var body: some View {
    GeometryReader { geometry in
      Color.clear
        .preference(
          key: FrameMeasurePreferenceKey.self,
          value: [identifier: geometry.frame(in: space)]
        )
    }
  }
}

extension View {
  /// Frame 측정을 위한 메서드
  public func setFrameMeasure(space: CoordinateSpace, identifier: AnyHashable) -> some View {
    return self.background(
      FrameMeasureGeometry(space: space, identifier: identifier)
    )
  }
  
  /// 측정된 Frame을 가져오기 위한 메서드
  public func getFrameMeasure(perform action: @escaping (FrameMeasurePreferenceKey.Value) -> Void) -> some View {
    return self.onPreferenceChange(FrameMeasurePreferenceKey.self) { value in
      action(value)
    }
  }
}
