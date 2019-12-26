//
//  APIManager.swift
//  TheMovies
//
//  Created by Mikhail Pchelnikov on 09/06/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import Foundation

import RxCocoa
import RxSwift

final public class APIManager {
    public static let shared = APIManager(session: URLSession.shared)
    
    private let session: URLSession

    public init(session: URLSession) {
        self.session = session
    }

    /// General method for API calling.
    ///
    /// - Parameter endpoint: Endpoint
    /// - Returns: Observable of Response Data.
    public func request(for endpoint: Endpoint) -> Single<Data> {
        guard let escString = endpoint.path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: escString) else {
                return .error(ApplicationError.apiError(type: .commonError))
        }

        let request = createRequest(from: url)

        return session.rx
            .response(request: request)
            .flatMap(handleResponse)
            .asSingle()
    }

    private func createRequest(from url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.cachePolicy = .reloadIgnoringCacheData
        return request
    }

    private func handleResponse(response: HTTPURLResponse, data: Data) throws -> Single<Data> {
        if 200 ..< 300 ~= response.statusCode {
            return .just(data)
        } else {
            throw ApplicationError.apiError(type:
                .responseError(error: String(data: data, encoding: .utf8))
            )
        }
    }
}
