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
                List(movService.searchResults) { result in
                    Text("Search result: \(result.id)")
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
