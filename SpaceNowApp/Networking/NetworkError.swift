//
//  NetworkError.swift
//  SpaceNowApp
//
//  Created by sonam taya on 7/12/21.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case request
    case decoding
    case network
    case unknown

    var reason: String {
        switch self {
        case .invalidUrl:
            return "Network Failure: Invalid URL"
        case .request:
            return "Network Failure: Error occurred while fetching data"
        case .decoding:
            return "Network Failure: Error occurred while decoding data"
        case .network:
            return "Network Failure: Unsuccessful HTTP response"
        case .unknown:
            return "Network Failure"
        }
    }
}
