//
//  Networkhelpers.swift
//  FavMov
//
//  Created by Kayes on 2/16/24.
//

import Foundation

enum NetworkError: Error, Identifiable {
    case invalidURL
    case notConnectedToInternet
    case serverError(description: String)
    case decodingError
    
    var id: String {
        switch self {
        case .notConnectedToInternet:
            return Constants.Alerts.noNetwork
        default:
            return Constants.Alerts.defaultTitle
        }
    }
}
