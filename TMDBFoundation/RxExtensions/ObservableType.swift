//
//  ObservableType.swift
//  TMDBFoundation
//
//  Created by Vlad Zagorodnyuk on 12/26/19.
//  Copyright © 2019 MERLin Tech. All rights reserved.
//

public extension ObservableType {
    func catchError<O: ObserverType>(sendTo errorObserver: O) -> Observable<Element> where O.Element == Error {
        return catchError {
            errorObserver.onNext($0)
            return .empty()
        }
    }
}
