//
//  Inject.swift
//  DIContainer
//
//  Created by 김지현 on 8/1/24.
//  Copyright © 2024 PomoNyang. All rights reserved.
//

import Foundation

@propertyWrapper
public class Inject<Value> {
    private let lazyValue: (() -> Value)
    private var storage: Value?

    public var wrappedValue: Value {
        storage ?? {
            let value: Value = lazyValue()
            storage = value
            return value
        }()
    }

    public init<K>(_ key: K.Type) where K : InjectionKey, Value == K.Value {
        lazyValue = {
            key.currentValue
        }
    }
}
