//
//  ImageCacheTests.swift
//  FetchRecipeApp
//
//  Created by Jolomi Mebaghanje on 4/15/25.
//

// I use this to test if the image cache is working correctly

import XCTest
@testable import FetchRecipeApp

final class ImageCacheTests: XCTestCase {

    func testImageCachingToDiskAndMemory() async {
        // test URL to download
        guard let testURL = URL(string: "https://via.placeholder.com/150") else {
            XCTFail("Invalid test URL")
            return
        }

        // try downloading image for first time
        let image = await ImageCache.shared.image(for: testURL)
        XCTAssertNotNil(image, "Expected image to be downloaded and cached")

        // try getting same image again to check cache works
        let cachedImage = await ImageCache.shared.image(for: testURL)
        XCTAssertNotNil(cachedImage, "Expected image to be retrieved from cache")
    }
}
