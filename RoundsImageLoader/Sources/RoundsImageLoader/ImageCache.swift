//
//  ImageCache.swift
//
//  Created by Rexhep Kelmendi on 26.7.24.
//
import UIKit

public class ImageCache {
    public static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()
    private var timestamps: [NSString: Date] = [:]
    private let cacheExpiryTime: TimeInterval = 4 * 60 * 60

    public func cacheImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
        timestamps[key as NSString] = Date()
    }

    public func getImage(forKey key: String) -> UIImage? {
        guard let timestamp = timestamps[key as NSString], Date().timeIntervalSince(timestamp) < cacheExpiryTime else {
            cache.removeObject(forKey: key as NSString)
            timestamps.removeValue(forKey: key as NSString)
            return nil
        }
        return cache.object(forKey: key as NSString)
    }

    public func invalidateCache() {
        cache.removeAllObjects()
        timestamps.removeAll()
    }
}
