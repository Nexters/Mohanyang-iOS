//
//  Product+Extension.swift
//  ProjectDescriptionHelpers
//
//  Created by MinseokKang on 2024/07/15.
//

import ProjectDescription

extension Product {
  var isResourceRequired: Bool {
    switch self {
    case .app,
        .framework,
        .staticFramework,
        .bundle,
        .unitTests,
        .uiTests,
        .appClip,
        .appExtension,
        .watch2App,
        .watch2Extension,
        .tvTopShelfExtension,
        .messagesExtension,
        .stickerPackExtension:
      return true
      
    case .staticLibrary,
        .dynamicLibrary,
        .commandLineTool,
        .xpc,
        .systemExtension,
        .extensionKitExtension,
        .macro:
      return false
      
    @unknown default:
      fatalError("\(self.rawValue) is not handled!")
    }
  }
}
