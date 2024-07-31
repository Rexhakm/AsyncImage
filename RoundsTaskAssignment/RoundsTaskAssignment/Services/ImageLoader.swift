//
//  ImageLoader.swift
//  RoundsTaskAssignment
//
//  Created by Rexhep Kelmendi on 26.7.24.
//

import Foundation
import Combine

class ImageLoader {

    static func loadFromURL() -> AnyPublisher<[ImageInfo], Error> {
        guard let url = URL(string: "https://zipoapps-storage-test.nyc3.digitaloceanspaces.com/image_list.json") else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output in
                guard let httpResponse = output.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .decode(type: [ImageInfo].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
