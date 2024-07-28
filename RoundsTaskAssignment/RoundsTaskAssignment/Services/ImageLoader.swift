//
//  ImageLoader.swift
//  RoundsTaskAssignment
//
//  Created by Rexhep Kelmendi on 26.7.24.
//

import Foundation

class ImageLoader {

    static func loadLocalJSON() -> [ImageInfo] {
        guard let path = Bundle.main.path(forResource: "images", ofType: "json") else {
            print("JSON file not found")
            return []
        }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let images = try JSONDecoder().decode([ImageInfo].self, from: data)
            return images
        } catch {
            print("Error decoding JSON: \(error)")
            return []
        }
    }
}


