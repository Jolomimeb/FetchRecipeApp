//
//  ImageCache.swift
//  FetchRecipeApp
//
//  Created by Jolomi Mebaghanje on 4/15/25.
//
// I use this file for loading and saving images to cache so we don’t reload them each time

import UIKit

final class ImageCache {
    static let shared = ImageCache() // singleton
    private var memoryCache = NSCache<NSString, UIImage>() // stores images in memory

    func image(for url: URL) async -> UIImage? {
        // if I already cached the image, use it
        if let cached = memoryCache.object(forKey: url.absoluteString as NSString) {
            return cached
        }

        // make a file path to save the image on disk
        let filename = url.lastPathComponent
        let localURL = FileManager.default.temporaryDirectory.appendingPathComponent(filename)

        // if the image was saved to disk, load from there
        if let data = try? Data(contentsOf: localURL), let image = UIImage(data: data) {
            memoryCache.setObject(image, forKey: url.absoluteString as NSString)
            return image
        }

        // otherwise, download the image and save it
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                memoryCache.setObject(image, forKey: url.absoluteString as NSString)
                try? data.write(to: localURL) // save it to disk
                return image
            }
        } catch {
            print("Failed to fetch image: \(error)")
        }

        return nil
    }
}
