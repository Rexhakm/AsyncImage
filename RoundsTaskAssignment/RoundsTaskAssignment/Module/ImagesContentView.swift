//
//  ContentView.swift
//  RoundsTaskAssignment
//
//  Created by Rexhep Kelmendi on 26.7.24.
//

import SwiftUI
import RoundsImageLoader

struct ImagesContentView: View {
    @State private var imageItems: [ImageInfo] = []
    private let imageCache : ImageCache

    init(imageCache: ImageCache = ImageCache.shared) {
        self.imageCache = imageCache
    }

    var body: some View {
        NavigationView {
            VStack {
                List(imageItems) { item in
                    VStack {
                        if let url = URL(string: item.url){
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
                imageItems = ImageLoader.loadLocalJSON()
            }
        }
    }
}

#Preview {
    ImagesContentView()
}
