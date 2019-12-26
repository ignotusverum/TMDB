//
//  Weakify.swift
//  TMDBFoundation
//
//  Created by Vlad Zagorodnyuk on 12/26/19.
//  Copyright © 2019 MERLin Tech. All rights reserved.
//

public func weakify<Obj: AnyObject, Return>(_ object: Obj, _ transform: @escaping (Obj) -> Return) -> () -> Return? {
    return { [weak object] in
        guard let strongObj = object else { return nil }
        return transform(strongObj)
    }
}

public func weakify<Obj: AnyObject, T, Return>(_ object: Obj, _ transform: @escaping (Obj, T) -> Return) -> (T) -> Return? {
    return { [weak object] element in
        guard let strongObj = object else { return nil }
        return transform(strongObj, element)
    }
}

public func weakify<Obj: AnyObject, T1, T2, Return>(_ object: Obj, _ transform: @escaping (Obj, T1, T2) -> Return) -> (T1, T2) -> Return? {
    return { [weak object] el1, el2 in
        guard let strongObj = object else { return nil }
        return transform(strongObj, el1, el2)
    }
}

public func weakify<Obj: AnyObject, T1, T2, T3, Return>(_ object: Obj, _ transform: @escaping (Obj, T1, T2, T3) -> Return) -> (T1, T2, T3) -> Return? {
    return { [weak object] el1, el2, el3 in
        guard let strongObj = object else { return nil }
        return transform(strongObj, el1, el2, el3)
    }
}

public func weakify<Obj: AnyObject, T1, T2, T3, T4, Return>(_ object: Obj, _ transform: @escaping (Obj, T1, T2, T3, T4) -> Return) -> (T1, T2, T3, T4) -> Return? {
    return { [weak object] el1, el2, el3, el4 in
        guard let strongObj = object else { return nil }
        return transform(strongObj, el1, el2, el3, el4)
    }
}

public func weakify<Obj: AnyObject, T1, T2, T3, T4, T5, Return>(_ object: Obj, _ transform: @escaping (Obj, T1, T2, T3, T4, T5) -> Return) -> (T1, T2, T3, T4, T5) -> Return? {
    return { [weak object] el1, el2, el3, el4, el5 in
        guard let strongObj = object else { return nil }
        return transform(strongObj, el1, el2, el3, el4, el5)
    }
}

public func weakify<Obj: AnyObject, T1, T2, T3, T4, T5, T6, Return>(_ object: Obj, _ transform: @escaping (Obj, T1, T2, T3, T4, T5, T6) -> Return) -> (T1, T2, T3, T4, T5, T6) -> Return? {
    return { [weak object] el1, el2, el3, el4, el5, el6 in
        guard let strongObj = object else { return nil }
        return transform(strongObj, el1, el2, el3, el4, el5, el6)
    }
}

public func weakify<Obj: AnyObject, T1, T2, T3, T4, T5, T6, T7, Return>(_ object: Obj, _ transform: @escaping (Obj, T1, T2, T3, T4, T5, T6, T7) -> Return) -> (T1, T2, T3, T4, T5, T6, T7) -> Return? {
    return { [weak object] el1, el2, el3, el4, el5, el6, el7 in
        guard let strongObj = object else { return nil }
        return transform(strongObj, el1, el2, el3, el4, el5, el6, el7)
    }
}

public func weakify<Obj: AnyObject, Return>(_ object: Obj, default: Return, _ transform: @escaping (Obj) -> Return) -> () -> Return {
    return { [weak object] in
        guard let strongObj = object else { return `default` }
        return transform(strongObj)
    }
}

public func weakify<Obj: AnyObject, T, Return>(_ object: Obj, default: Return, _ transform: @escaping (Obj, T) -> Return) -> (T) -> Return {
    return { [weak object] element in
        guard let strongObj = object else { return `default` }
        return transform(strongObj, element)
    }
}

public func weakify<Obj: AnyObject, T1, T2, Return>(_ object: Obj, default: Return, _ transform: @escaping (Obj, T1, T2) -> Return) -> (T1, T2) -> Return {
    return { [weak object] el1, el2 in
        guard let strongObj = object else { return `default` }
        return transform(strongObj, el1, el2)
    }
}

public func weakify<Obj: AnyObject, T1, T2, T3, Return>(_ object: Obj, default: Return, _ transform: @escaping (Obj, T1, T2, T3) -> Return) -> (T1, T2, T3) -> Return {
    return { [weak object] el1, el2, el3 in
        guard let strongObj = object else { return `default` }
        return transform(strongObj, el1, el2, el3)
    }
}

public func weakify<Obj: AnyObject, T1, T2, T3, T4, Return>(_ object: Obj, default: Return, _ transform: @escaping (Obj, T1, T2, T3, T4) -> Return) -> (T1, T2, T3, T4) -> Return {
    return { [weak object] el1, el2, el3, el4 in
        guard let strongObj = object else { return `default` }
        return transform(strongObj, el1, el2, el3, el4)
    }
}

public func weakify<Obj: AnyObject, T1, T2, T3, T4, T5, Return>(_ object: Obj, default: Return, _ transform: @escaping (Obj, T1, T2, T3, T4, T5) -> Return) -> (T1, T2, T3, T4, T5) -> Return {
    return { [weak object] el1, el2, el3, el4, el5 in
        guard let strongObj = object else { return `default` }
        return transform(strongObj, el1, el2, el3, el4, el5)
    }
}

public func weakify<Obj: AnyObject, T1, T2, T3, T4, T5, T6, Return>(_ object: Obj, default: Return, _ transform: @escaping (Obj, T1, T2, T3, T4, T5, T6) -> Return) -> (T1, T2, T3, T4, T5, T6) -> Return {
    return { [weak object] el1, el2, el3, el4, el5, el6 in
        guard let strongObj = object else { return `default` }
        return transform(strongObj, el1, el2, el3, el4, el5, el6)
    }
}

public func weakify<Obj: AnyObject, T1, T2, T3, T4, T5, T6, T7, Return>(_ object: Obj, default: Return, _ transform: @escaping (Obj, T1, T2, T3, T4, T5, T6, T7) -> Return) -> (T1, T2, T3, T4, T5, T6, T7) -> Return {
    return { [weak object] el1, el2, el3, el4, el5, el6, el7 in
        guard let strongObj = object else { return `default` }
        return transform(strongObj, el1, el2, el3, el4, el5, el6, el7)
    }
}

