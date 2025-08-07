//
//  DottedLine.swift
//  DesignSystem
//
//  Created by devMinseok on 8/1/25.
//  Copyright © 2025 PomoNyang. All rights reserved.
//

import SwiftUI

public struct DottedLine: View {
  public enum Orientation {
    case horizontal
    case vertical
  }

  /// 색상
  let color: Color
  /// 선 굵기
  let lineWidth: CGFloat
  /// [점 길이, 빈 공간 길이]
  let dash: [CGFloat]
  /// 방향 (기본: 가로)
  let orientation: Orientation

  public init(
    _ orientation: Orientation,
    color: Color,
    lineWidth: CGFloat = 1,
    dash: [CGFloat] = [4, 4]
  ) {
    self.orientation = orientation
    self.color = color
    self.lineWidth = lineWidth
    self.dash = dash
  }

  public var body: some View {
    GeometryReader { proxy in
      Path { path in
        switch orientation {
        case .horizontal:
          let y = proxy.size.height / 2
          path.move(to: .init(x: 0, y: y))
          path.addLine(to: .init(x: proxy.size.width, y: y))

        case .vertical:
          let x = proxy.size.width / 2
          path.move(to: .init(x: x, y: 0))
          path.addLine(to: .init(x: x, y: proxy.size.height))
        }
      }
      .stroke(style: StrokeStyle(
        lineWidth: lineWidth,
        lineCap: .square,
        dash: dash
      ))
      .foregroundStyle(color)
    }
    .frame(
      width: orientation == .vertical ? lineWidth : nil,
      height: orientation == .horizontal ? lineWidth : nil
    )
  }
}
