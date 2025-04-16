//
//  RecipeService.swift
//  FetchRecipeApp
//
//  Created by Jolomi Mebaghanje on 4/15/25.
//

// I use this file to handle calling the API to get the recipe data

import Foundation

final class RecipeService {
    static let shared = RecipeService() // singleton
    private let endpoint = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!

    // this gets all the recipes from the API
    func fetchRecipes() async throws -> [Recipe] {
        let (data, _) = try await URLSession.shared.data(from: endpoint)
        let response = try JSONDecoder().decode([String: [Recipe]].self, from: data)
        guard let recipes = response["recipes"] else {
            throw URLError(.badServerResponse)
        }
        return recipes
    }
}
