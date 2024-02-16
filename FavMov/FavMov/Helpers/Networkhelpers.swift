//
//  Networkhelpers.swift
//  FavMov
//
//  Created by Kayes on 2/16/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case notConnectedToInternet
    case serverError(description: String)
    case decodingError
}
