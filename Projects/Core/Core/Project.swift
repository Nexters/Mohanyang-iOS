//
//  Project.swift
//  CoreManifests
//
//  Created by devMinseok on 8/16/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

@_spi(Core)
import DependencyPlugin

let project: Project = .makeRootProject(
  rootModule: Core.self,
  scripts: [],
  product: .staticLibrary
)
