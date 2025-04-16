//
//  ContentView.swift
//  FetchRecipeApp
//
//  Created by Jolomi Mebaghanje on 4/15/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = RecipeViewModel()

    var body: some View {
        TabView {
            NavigationView {
                VStack {
                    TextField("Search by name or cuisine", text: $viewModel.searchQuery)
                        .textFieldStyle(.roundedBorder)
                        .padding([.horizontal, .top])

                    Group {
                        if viewModel.isLoading {
                            ProgressView()
                        } else if let error = viewModel.errorMessage {
                            Text(error).foregroundColor(.red).multilineTextAlignment(.center).padding()
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

            NavigationView {
                SavedRecipesView()
            }
            .tabItem {
                Label("Saved", systemImage: "heart")
            }
        }
        .environmentObject(viewModel)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
