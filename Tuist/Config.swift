//
//  Framework.swift
//  Config
//
//  Created by MinseokKang on 2024/07/15.
//

import ProjectDescription

let config = Config(
  plugins: [
    .local(path: .relativeToRoot("Plugins/UtilityPlugin")),
    .local(path: .relativeToRoot("Plugins/DependencyPlugin"))
  ]
)
