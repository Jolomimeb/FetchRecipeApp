//
//  ImageCache.swift
//  FetchRecipeApp
//
//  Created by Jolomi Mebaghanje on 4/15/25.
//

import UIKit

final class ImageCache {
    static let shared = ImageCache()
    private var memoryCache = NSCache<NSString, UIImage>()

    func image(for url: URL) async -> UIImage? {
        if let cached = memoryCache.object(forKey: url.absoluteString as NSString) {
            return cached
        }

        let filename = url.lastPathComponent
        let localURL = FileManager.default.temporaryDirectory.appendingPathComponent(filename)

        if let data = try? Data(contentsOf: localURL), let image = UIImage(data: data) {
            memoryCache.setObject(image, forKey: url.absoluteString as NSString)
            return image
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                memoryCache.setObject(image, forKey: url.absoluteString as NSString)
                try? data.write(to: localURL)
                return image
            }
        } catch {
            print("Failed to fetch image: \(error)")
        }

        return nil
    }
}
