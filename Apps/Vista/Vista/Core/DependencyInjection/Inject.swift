//
//  Inject.swift
//  Vista
//
//  Created by Lucas Takatori on 3/13/25.
//

import Swinject

@propertyWrapper
struct Inject<T> {
    let wrappedValue: T

    init() {
        guard let resolvedValue = container.resolve(T.self) else {
            fatalError("Dependency of type \(T.self) could not be resolved!")
        }
        self.wrappedValue = resolvedValue
    }
}
