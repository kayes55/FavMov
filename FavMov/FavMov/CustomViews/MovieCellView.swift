//
//  MovieCellView.swift
//  FavMov
//
//  Created by Kayes on 2/16/24.
//

import SwiftUI

struct MovieCellView: View {
    var movie: Movie
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            
            AsyncImageView(urlString: self.backdropImageURL(of: movie)) {
                // Placeholder view
                Image(systemName: "film")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 150)
                    .cornerRadius(8)
            }
            .cornerRadius(8.0)

            VStack(alignment: .leading, spacing: 4) {
                Text(movie.originalTitle)
                    .font(.headline)
                Text(movie.overview)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.trailing, 8)
            
        }
        .padding(8)
    }
    
    private func backdropImageURL(of movie: Movie) -> String {
        guard let posterPath = movie.backdropPath else {
            return Constants.ApiImageURL.backdropPlaceholder
        }
        return Constants.ApiImageURL.highQuality + posterPath
    }
}
