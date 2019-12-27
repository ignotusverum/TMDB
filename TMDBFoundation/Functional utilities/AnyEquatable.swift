//
//  AnyEquatable.swift
//  TMDBFoundation
//
//  Created by Vlad Zagorodnyuk on 12/27/19.
//  Copyright © 2019 MERLin Tech. All rights reserved.
//

public protocol GenericEquatable {
    func isEqual(to other: GenericEquatable) -> Bool
}

public extension GenericEquatable where Self: Equatable {
    func isEqual(to other: GenericEquatable) -> Bool {
        guard let other = other as? Self else { return false }
        return self == other
    }
}

public struct AnyEquatable: Equatable {
    private struct ImplicitlyGenericEquatable<T: Equatable>: Equatable, GenericEquatable {
        let equatable: T
    }
    
    let wrapped: GenericEquatable
    public init(wrapped: GenericEquatable) {
        self.wrapped = wrapped
    }
    
    public init<T: Equatable>(wrapped: T) {
        self.wrapped = ImplicitlyGenericEquatable(equatable: wrapped)
    }
    
    public static func == (lhs: AnyEquatable, rhs: AnyEquatable) -> Bool {
        return lhs.wrapped.isEqual(to: rhs.wrapped)
    }
}

extension AnyEquatable: ExpressibleByStringLiteral, ExpressibleByStringInterpolation {
    public init(stringLiteral value: String) {
        self.init(wrapped: value)
    }
}

extension AnyEquatable: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self.init(wrapped: value)
    }
}

extension AnyEquatable: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Float) {
        self.init(wrapped: value)
    }
}

extension AnyEquatable: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: AnyEquatable...) {
        self.init(wrapped: elements)
    }
}

