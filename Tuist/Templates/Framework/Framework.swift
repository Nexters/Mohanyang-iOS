//
//  Framework.swift
//  ProjectDescriptionHelpers
//
//  Created by MinseokKang on 2024/07/15.
//

import ProjectDescription

let layerAttribute: Template.Attribute = .required("layer")
let nameAttribute: Template.Attribute = .required("name")
let platformAttribute: Template.Attribute = .optional("platform", default: "ios")

let template = Template(
  description: "Generate Module",
  attributes: [
    layerAttribute,
    nameAttribute,
    platformAttribute
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
      path: "Projects/\(layerAttribute)/\(nameAttribute)/Example/Sources/AppDelegate.swift",
      templatePath: "Stencil/AppDelegate.stencil"
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
    ),
    
    // MARK: - Preview
    .file(
      path: "Projects/\(layerAttribute)/\(nameAttribute)/Preview/Sources/\(nameAttribute).swift",
      templatePath: "Stencil/Source.stencil"
    ),
    .string(
      path: "Projects/\(layerAttribute)/\(nameAttribute)/Preview/Resources/dummy.txt",
      contents: "dummy file"
    )
  ]
)
