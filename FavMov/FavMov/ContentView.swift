//
//  ContentView.swift
//  FavMov
//
//  Created by Kayes on 2/16/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var movService = MovieSearchService()
    @State private var searchText = ""
        
    var body: some View {
        NavigationView {
            VStack {
                if movService.searchResults.isEmpty {
                    Text("Search a movie")
                }
                List(movService.searchResults) { result in
                    MovieCellView(movie: result)
                }
                .navigationTitle("Search")
                .searchable(text: $searchText)
                .onChange(of: searchText) { _ in
                    movService.search(query: searchText)
                }
            }
            
        }
        
    }
}

#Preview {
    ContentView()
}
