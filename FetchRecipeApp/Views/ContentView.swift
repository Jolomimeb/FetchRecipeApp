//
//  ContentView.swift
//  FetchRecipeApp
//
//  Created by Jolomi Mebaghanje on 4/15/25.
//

// This is the main screen with tabs for all recipes and saved ones

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = RecipeViewModel() // shared across views

    var body: some View {
        TabView {
            // First tab for all recipes
            NavigationView {
                VStack {
                    // search bar
                    TextField("Search by name or cuisine", text: $viewModel.searchQuery)
                        .textFieldStyle(.roundedBorder)
                        .padding([.horizontal, .top])

                    Group {
                        // loading spinner
                        if viewModel.isLoading {
                            ProgressView()
                        // error message
                        } else if let error = viewModel.errorMessage {
                            Text(error).foregroundColor(.red).multilineTextAlignment(.center).padding()
                        // list of filtered recipes
                        } else {
                            List(viewModel.filteredRecipes) { recipe in
                                NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                    RecipeRow(recipe: recipe)
                                }
                            }
                            .listStyle(.plain)
                            .refreshable {
                                await viewModel.loadRecipes()
                            }
                        }
                    }
                    .navigationTitle("Recipes")
                    .task {
                        await viewModel.loadRecipes()
                    }
                }
            }
            .tabItem {
                Label("All Recipes", systemImage: "list.bullet")
            }

            // Second tab for saved recipes
            NavigationView {
                SavedRecipesView()
            }
            .tabItem {
                Label("Saved", systemImage: "heart")
            }
        }
        .environmentObject(viewModel) // share view model everywhere
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
