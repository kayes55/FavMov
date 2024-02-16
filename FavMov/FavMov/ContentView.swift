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
    @State private var showAlert: Bool = false
        
    var body: some View {
        NavigationView {
            ZStack {
                if movService.searchResults.isEmpty {
                    HStack {
                        Image(systemName: "film")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text(Constants.Search.placeholder)
                            .font(.headline)
                    }
                    
                }
                List(movService.searchResults) { result in
                    MovieCellView(movie: result)
                }
                .navigationTitle("Movie List")
                .searchable(text: $searchText)
                .onChange(of: searchText) { _ in
                    movService.search(query: searchText)
                }
            }
            .alert(item: $movService.error) { error in
                Alert(title: Text("Warning!"), message: Text(error.id), dismissButton: .default(Text("OK")) {
                    movService.clearError()
                })
            }
            
        }
        
    }
}

#Preview {
    ContentView()
}
