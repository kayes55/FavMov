//
//  AsyncImageView.swift
//  FavMov
//
//  Created by Kayes on 2/16/24.
//

import SwiftUI
import Combine

struct AsyncImageView<Placeholder: View>: View {
    @StateObject private var imageLoader: ImageLoader
    private let placeholder: Placeholder

    init(urlString: String, @ViewBuilder placeholder: () -> Placeholder) {
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL string: \(urlString)")
        }
        _imageLoader = StateObject(wrappedValue: ImageLoader(url: url))
        self.placeholder = placeholder()
    }

    var body: some View {
        if let image = imageLoader.image {
            Image(uiImage: image)
                .resizable()
                .frame(width: 80, height: 120)
                .aspectRatio(contentMode: .fit)
        } else {
            placeholder
        }
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var cancellable: AnyCancellable?
    
    init(url: URL) {
        loadImage(from: url)
    }
    
    
    private func loadImage(from url: URL) {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }
}
