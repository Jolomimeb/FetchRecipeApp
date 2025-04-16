//
//  ImageCacheTests.swift
//  FetchRecipeApp
//
//  Created by Jolomi Mebaghanje on 4/15/25.
//

import XCTest
@testable import FetchRecipeApp

final class ImageCacheTests: XCTestCase {

    func testImageCachingToDiskAndMemory() async {
        guard let testURL = URL(string: "https://via.placeholder.com/150") else {
            XCTFail("Invalid test URL")
            return
        }

        let image = await ImageCache.shared.image(for: testURL)
        XCTAssertNotNil(image, "Expected image to be downloaded and cached")

        let cachedImage = await ImageCache.shared.image(for: testURL)
        XCTAssertNotNil(cachedImage, "Expected image to be retrieved from cache")
    }
}
