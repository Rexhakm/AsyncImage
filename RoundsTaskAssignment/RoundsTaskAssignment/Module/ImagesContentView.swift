//
//  ContentView.swift
//  RoundsTaskAssignment
//
//  Created by Rexhep Kelmendi on 26.7.24.
//

import SwiftUI
import RoundsImageLoader
import Combine

struct ImagesContentView: View {
    @State private var imageItems: [ImageInfo] = []
    @State private var cancellable: AnyCancellable?
    private let imageCache : ImageCache


    init(imageCache: ImageCache = ImageCache.shared) {
        self.imageCache = imageCache
    }

    var body: some View {
        NavigationView {
            VStack {
                List(imageItems) { item in
                    VStack {
                        if let url = URL(string: item.imageUrl){
                            AsyncImageView(url: url, placeholder: UIImage(named: "placeholder.png"))
                                .cornerRadius(8)
                        }
                        Text("\(item.id)")
                    }
                    .frame(height: 300)
                }
            }
            .navigationBarTitle("Image List")
            .navigationBarItems(trailing: Button("Invalidate Cache") {
                imageCache.invalidateCache()
            })
            .onAppear {
                loadImages()
            }
        }
    }

    private func loadImages() {
        cancellable = ImageLoader.loadFromURL()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error loading images: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { images in
                imageItems = images
            })
    }
}

#Preview {
    ImagesContentView()
}
