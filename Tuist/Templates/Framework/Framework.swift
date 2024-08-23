//
//  Framework.swift
//  ProjectDescriptionHelpers
//
//  Created by MinseokKang on 2024/07/15.
//

import Foundation
import ProjectDescription

func getNowDateString() -> String {
  let formatter = DateFormatter()
  formatter.dateFormat = "M/d/yy"
  return formatter.string(from: Date())
}

let layerAttribute: Template.Attribute = .required("layer")
let nameAttribute: Template.Attribute = .required("name")
let nowDateAttribute: Template.Attribute = .optional("nowDate", default: .string(getNowDateString()))

let template = Template(
  description: "Generate Module",
  attributes: [
    layerAttribute,
    nameAttribute,
    nowDateAttribute
  ],
  items: [ // 템플릿 전부 생성
    // MARK: - Project
    .file(
      path: "Projects/\(layerAttribute)/\(nameAttribute)/Project.swift",
      templatePath: "Stencil/Project.stencil"
    ),

    // MARK: - Sources
    .file(
      path: "Projects/\(layerAttribute)/\(nameAttribute)/Sources/\(nameAttribute).swift",
      templatePath: "Stencil/Source.stencil"
    ),

    // MARK: - Resources
    .string(
      path: "Projects/\(layerAttribute)/\(nameAttribute)/Resources/dummy.txt",
      contents: "dummy file"
    ),

    // MARK: - Interface
    .file(
      path: "Projects/\(layerAttribute)/\(nameAttribute)/Interface/\(nameAttribute)Interface.swift",
      templatePath: "Stencil/Interface.stencil"
    ),

    // MARK: - Tests
    .file(
      path: "Projects/\(layerAttribute)/\(nameAttribute)/Tests/\(nameAttribute)Tests.swift",
      templatePath: "Stencil/Tests.stencil"
    ),

    // MARK: - Testing
    .file(
      path: "Projects/\(layerAttribute)/\(nameAttribute)/Testing/\(nameAttribute)Testing.swift",
      templatePath: "Stencil/Testing.stencil"
    ),

    // MARK: - Example
    .file(
      path: "Projects/\(layerAttribute)/\(nameAttribute)/Example/Sources/\(nameAttribute)App.swift",
      templatePath: "Stencil/App.stencil"
    ),
    .file(
      path: "Projects/\(layerAttribute)/\(nameAttribute)/Example/Sources/ContentView.swift",
      templatePath: "Stencil/ContentView.stencil"
    ),
    .file(
      path: "Projects/\(layerAttribute)/\(nameAttribute)/Example/Resources/LaunchScreen.storyboard",
      templatePath: "Stencil/LaunchScreen.stencil"
    ),
    .directory(
      path: "Projects/\(layerAttribute)/\(nameAttribute)/Example/Resources/",
      sourcePath: "Font"
    ),
    .directory(
      path: "Projects/\(layerAttribute)/\(nameAttribute)/Example/Resources/",
      sourcePath: "Assets.xcassets"
    )
  ]
)
