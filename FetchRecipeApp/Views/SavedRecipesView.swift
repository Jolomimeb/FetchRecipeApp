//
//  SavedRecipesView.swift
//  FetchRecipeApp
//
//  Created by Jolomi Mebaghanje on 4/16/25.
//

// This is the file that shows a list of recipes that user has saved

import SwiftUI

struct SavedRecipesView: View {
    @EnvironmentObject var viewModel: RecipeViewModel

    var body: some View {
        List(viewModel.savedRecipes.sorted(by: { $0.name < $1.name })) { recipe in
            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                RecipeRow(recipe: recipe)
            }
        }
        .navigationTitle("Saved Recipes")
    }
}
