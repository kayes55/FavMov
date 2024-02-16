//
//  Endpoint.swift
//  FavMov
//
//  Created by Kayes on 2/16/24.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var body: [String : String]? { get }
    var method: HttpMethod { get }
    var queryParams: [String: Any]? { get }
}

extension Endpoint {
    
    // The Movies Database API
    // Docs: https://developers.themoviedb.org/3/getting-started/introduction
    
    var completeUrl: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.themoviedb.org"
        urlComponents.path = "/3" + path
        urlComponents.queryItems = queryParams?.compactMap {
            URLQueryItem(name: $0.key, value: "\($0.value)")
        }
        
        return urlComponents.url
    }
}
