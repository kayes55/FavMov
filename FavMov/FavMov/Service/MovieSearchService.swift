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
    private var cancellable: AnyCancellable?
    
    private func fetchData<T: Decodable>(from url: URL, decodingTo type: T.Type) -> AnyPublisher<T, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
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
                    return NetworkError.notConnectedToInternet
                default:
                    return NetworkError.serverError(description: error.localizedDescription)
                }
            }
//            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func search(query: String) {
        cancellable?.cancel()
        
        let baseURL = "https://api.themoviedb.org/3/search/movie?api_key=38e61227f85671163c275f9bd95a8803"
        let url = URL(string: "\(baseURL)&query=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")")!
        
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
                print("search results \(String(describing: self?.searchResults.count))")
            })
    }
}
