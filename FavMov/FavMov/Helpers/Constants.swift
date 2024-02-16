//
//  Constants.swift
//  FavMov
//
//  Created by Kayes on 2/16/24.
//

import Foundation

struct Constants {
    
    static let notAvailable = "N/A"
    
    struct APIKey {
        static let key = "38e61227f85671163c275f9bd95a8803"
    }
    
    struct Icons {
        static let appLogo = "Logo"
    }

    struct Search {
        static let emptyStateWelcomeText = "Type a movie name to start."
        static let emptyStateNoResultsText = "Sorry! We couldn't find any results."
        static let placeholder = "Search movies"
        static let noResultsImage = "NoResults"
    }
    struct Alerts {
        static let defaultTitle = "Oops"
        static let defaultButtonTitle = "OK"
        static let tryAgainButtonTitle = "Try Again"
    }
    struct Identifiers {
        static let MovieCell = "MovieCell"
    }
    struct ApiImageURL {
        static let highQuality = "https://image.tmdb.org/t/p/w780"
        static let mediumQuality = "https://image.tmdb.org/t/p/w342"
        static let lowQuality = "https://image.tmdb.org/t/p/w154"
        static let posterPlaceholder = "https://critics.io/img/movies/poster-placeholder.png"
        static let backdropPlaceholder = "https://image.xumo.com/v1/assets/asset/XM05YG2LULFZON/600x340.jpg"
    }
}
