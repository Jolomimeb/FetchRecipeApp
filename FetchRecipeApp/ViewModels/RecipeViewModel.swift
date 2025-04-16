//
//  RecipeViewModel.swift
//  FetchRecipeApp
//
//  Created by Jolomi Mebaghanje on 4/15/25.
//

import Foundation

@MainActor
final class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var savedRecipes: Set<Recipe> = []
    @Published var errorMessage: String?
    @Published var isLoading = false
    @Published var searchQuery: String = ""

    var filteredRecipes: [Recipe] {
        if searchQuery.isEmpty { return recipes }
        return recipes.filter {
            $0.name.localizedCaseInsensitiveContains(searchQuery) ||
            $0.cuisine.localizedCaseInsensitiveContains(searchQuery)
        }
    }

    func toggleSaved(_ recipe: Recipe) {
        if savedRecipes.contains(recipe) {
            savedRecipes.remove(recipe)
        } else {
            savedRecipes.insert(recipe)
        }
    }

    func isSaved(_ recipe: Recipe) -> Bool {
        return savedRecipes.contains(recipe)
    }

    func loadRecipes() async {
        isLoading = true
        defer { isLoading = false }

        do {
            let results = try await RecipeService.shared.fetchRecipes()
            recipes = results
            errorMessage = results.isEmpty ? "No recipes available." : nil
        } catch {
            recipes = []
            errorMessage = "Failed to load recipes."
        }
    }
}
