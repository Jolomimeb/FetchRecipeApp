//
//  RecipeViewModel.swift
//  FetchRecipeApp
//
//  Created by Jolomi Mebaghanje on 4/15/25.
//
// I use file to handle all the logic for loading, saving, filtering recipes

import Foundation

@MainActor
final class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = [] // all recipes from API
    @Published var savedRecipes: Set<Recipe> = [] // recipes user liked
    @Published var errorMessage: String? // error to show in UI
    @Published var isLoading = false // loading state for spinner
    @Published var searchQuery: String = "" // text typed into search

    // this filters recipes by search query
    var filteredRecipes: [Recipe] {
        if searchQuery.isEmpty { return recipes }
        return recipes.filter {
            $0.name.localizedCaseInsensitiveContains(searchQuery) ||
            $0.cuisine.localizedCaseInsensitiveContains(searchQuery)
        }
    }

    // toggles saved or unsaved state for a recipe
    func toggleSaved(_ recipe: Recipe) {
        if savedRecipes.contains(recipe) {
            savedRecipes.remove(recipe)
        } else {
            savedRecipes.insert(recipe)
        }
    }

    // checks if a recipe is already saved
    func isSaved(_ recipe: Recipe) -> Bool {
        return savedRecipes.contains(recipe)
    }

    // calls the RecipeService to get recipes and update state
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
