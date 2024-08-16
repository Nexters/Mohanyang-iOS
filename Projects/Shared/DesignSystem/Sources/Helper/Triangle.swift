//
//  Triangle.swift
//  DesignSystem
//
//  Created by devMinseok on 8/9/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import SwiftUI

struct Triangle: View {
  enum Direction: Double {
    case down = 180
    case left = -90
    case up = 0
    case right = 90
  }
  
  private let direction: Direction
  private let color: Color
  
  init(direction: Direction, color: Color) {
    self.direction = direction
    self.color = color
  }
  
  var body: some View {
    TriangleShape()
      .fill(color)
      .rotationEffect(Angle.degrees(direction.rawValue))
  }
}

private struct TriangleShape: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    path.move(to: CGPoint(x: rect.midX, y: rect.minY))
    path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
    return path
  }
}
