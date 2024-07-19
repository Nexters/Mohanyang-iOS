//
//  PomoNyang.swift
//  DependencyPlugin
//
//  Created by MinseokKang on 2024/07/15.
//

import ProjectDescription

@_spi(PomoNyang)
public enum PomoNyang {
  public enum Feature: Modulable {
    case AppFeature
  }
  
  public enum Domain: Modulable {
    case AppService
    case Model
  }
  
  public enum Core: Modulable {
    case APIClient
  }
  
  public enum Shared: Modulable {
    case DesignSystem
    case Utils
    case Logger
  }
}


// MARK: - Path 정의

extension PomoNyang.Feature {
  public var path: String {
    let typeName = String(describing: self)
    return "Feature/\(typeName)"
  }
}

extension PomoNyang.Domain {
  public var path: String {
    let typeName = String(describing: self)
    return "Domain/\(typeName)"
  }
}

extension PomoNyang.Core {
  public var path: String {
    let typeName = String(describing: self)
    return "Core/\(typeName)"
  }
}

extension PomoNyang.Shared {
  public var path: String {
    let typeName = String(describing: self)
    return "Shared/\(typeName)"
  }
}
