//
//  MoviesEndpoint.swift
//  FavMov
//
//  Created by Kayes on 2/16/24.
//

import Foundation

enum MoviesEndpoint {
    case searchMovie(query: String)
}

extension MoviesEndpoint: Endpoint {
    var path: String {
        switch self {
        case .searchMovie:
            return "/search/movie"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .searchMovie:
            return .get
        }
    }
    
    var queryParams: [String : Any]? {
        switch self {
        case .searchMovie(let query):
            return [
                "api_key" : Constants.APIKey.key,
                "query": query
            ]
        }
    }
    
    var body: [String : String]? {
        switch self {
        case .searchMovie:
            return nil
        }
    }
}

