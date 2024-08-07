//
//  NetworkingErrors.swift
//  YandexSMD_HW_Zheliba
//
//  Created by Egor Anoshin on 19.07.2024.
//

import Foundation

enum NetworkingErrors: Error, Equatable {
    case incorrectURL(String)
    case unexpectedResponse(URLResponse)
    case badRequest
    case authError
    case notFound
    case serverError
    case unexpectedStatusCode(Int)
    case noConnection
}

extension NetworkingErrors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .incorrectURL(let url):
            return "The url \(url) does not exist"
        case .unexpectedResponse:
            return "Unexpected response from server"
        case .badRequest:
            return "Wrong request or unsynchronized data"
        case .authError:
            return "Wrong authorization"
        case .notFound:
            return "Element not found"
        case .serverError:
            return "Server error"
        case .unexpectedStatusCode(let code):
            return "Unexpected status code: \(code)"
        case .noConnection:
            return "No internet connection"
        }
    }
}
