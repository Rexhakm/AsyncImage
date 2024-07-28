//
//  AsyncImageView.swift
//
//  Created by Rexhep Kelmendi on 26.7.24.
//

import SwiftUI

@available(iOS 13.0, *)
public struct AsyncImageView: View {
    @State private var image: UIImage?
    public var url: URL
    public var placeholder: UIImage?
    private let imageDownloader: ImageDownloader
    private let imageCache: ImageCache

    public init(url: URL,
                placeholder: UIImage?,
                imageDownloader: ImageDownloader = ImageDownloader.shared,
                imageCache: ImageCache = ImageCache.shared) {
        self.url = url
        self.placeholder = placeholder
        self.imageDownloader = imageDownloader
        self.imageCache = imageCache
    }

    public var body: some View {
        Image(uiImage: image ?? placeholder ?? UIImage())
            .resizable()
            .onAppear {
                loadImage()
            }
    }

    private func loadImage() {
        if let cachedImage = imageCache.getImage(forKey: url.absoluteString) {
            image = cachedImage
        } else {
            imageDownloader.downloadImage(from: url) { downloadedImage in
                guard let downloadedImage = downloadedImage else { return }
                imageCache.cacheImage(downloadedImage, forKey: url.absoluteString)
                image = downloadedImage
            }
        }
    }
}
