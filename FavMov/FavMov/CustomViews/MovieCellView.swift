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
            Image(systemName: "film")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 150)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(movie.originalTitle)
                    .font(.headline)
                Text(movie.overview)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
//                    .lineLimit(2)
            }
            .padding(.trailing, 8)
            
            Spacer()
        }
        .padding(8)
    }
}
