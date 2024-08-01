//
//  Module.swift
//  DIContainer
//
//  Created by 김지현 on 8/1/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

public protocol Injectable {}

public protocol InjectionKey {
    associatedtype Value
    static var currentValue: Self.Value { get }
}

public extension InjectionKey {
    static var currentValue: Value {
        return Container.resolve(for: Self.self)
    }
}

public struct Module {
    let name: String
    let resolve: () -> Injectable

    public init<T: InjectionKey>(_ name: T.Type, _ resolve: @escaping () -> Injectable) {
        self.name = String(describing: name)
        self.resolve = resolve
    }
}
