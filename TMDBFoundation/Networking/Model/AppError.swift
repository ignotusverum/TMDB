//
//  AppError.swift
//  TheMovies
//
//  Created by Mikhail Pchelnikov on 13/11/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import Foundation

public protocol AppError: Error {
    var description: String { get }
}

/// Common applicatin errors.
public enum ApplicationError: AppError {
    case commonError, noResultsError, apiError(type: ApiErrorType)
    
    public var description: String {
        switch self {
        case .commonError: return "Common error"
        case .noResultsError: return "No results"
        case .apiError(let apiError): return apiError.description
        }
    }
}

/// Errors, which can occur while working with API.
public enum ApiErrorType: AppError {
    case commonError, serverError, parseError, responseError(error: String?)
    
    public var description: String {
        switch self {
        case .commonError: return "Common API error"
        case .parseError: return "Parse Error"
        case let .responseError(error): return "Response Error: \(error ?? "unknown")"
        case .serverError: return "Server Error"
        }
    }
}

