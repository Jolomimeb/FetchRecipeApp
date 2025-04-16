//
//  RecipeServiceTests.swift
//  FetchRecipeApp
//
//  Created by Jolomi Mebaghanje on 4/15/25.
//

import XCTest
@testable import FetchRecipeApp

final class RecipeServiceTests: XCTestCase {

    func testFetchRecipesSuccess() async throws {
        let recipes = try await RecipeService.shared.fetchRecipes()
        XCTAssertFalse(recipes.isEmpty, "Expected non-empty recipe list")
    }

    func testMalformedDataHandling() async {
        let badEndpoint = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")!
        let session = URLSession.shared

        do {
            let (data, _) = try await session.data(from: badEndpoint)
            _ = try JSONDecoder().decode([String: [Recipe]].self, from: data)
            XCTFail("Expected decoding to fail with malformed data")
        } catch {
            // Expected
        }
    }

    func testEmptyRecipeData() async throws {
        let emptyEndpoint = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")!
        let (data, _) = try await URLSession.shared.data(from: emptyEndpoint)
        let response = try JSONDecoder().decode([String: [Recipe]].self, from: data)
        let recipes = response["recipes"] ?? []
        XCTAssertTrue(recipes.isEmpty, "Expected empty recipe array")
    }
}
