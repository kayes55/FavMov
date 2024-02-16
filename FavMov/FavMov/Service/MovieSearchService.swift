//
//  MovieSearchService.swift
//  FavMov
//
//  Created by Kayes on 2/16/24.
//

import Foundation
import Combine

class MovieSearchService: ObservableObject {
    @Published var searchResults: [Movie] = []
    @Published var error: NetworkError?
    private var cancellable: AnyCancellable?
    
    private func fetchData<T: Decodable>(from url: URL, decodingTo type: T.Type) -> AnyPublisher<T, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    throw NetworkError.serverError(description: "Invalid server response")
                }
                return data
            }
            .mapError { error in
                // Map URLError to NetworkError
                switch error {
                case URLError.badURL, URLError.unsupportedURL:
                    return NetworkError.invalidURL
                case URLError.notConnectedToInternet:
                    self.error = .notConnectedToInternet
                    return NetworkError.notConnectedToInternet
                default:
                    return NetworkError.serverError(description: error.localizedDescription)
                }
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func search(query: String) {
        cancellable?.cancel()
        guard let url = MoviesEndpoint.searchMovie(query: query).completeUrl else {
            return
        }
        
        cancellable = fetchData(from: url, decodingTo: Movies.self)
            .mapError { _ in NetworkError.decodingError } // Handling decoding errors
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] searchResults in
                self?.searchResults = searchResults.results
            })
    }
    
    func clearError() {
            error = nil
        }
}
