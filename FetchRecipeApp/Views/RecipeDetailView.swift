//
//  RecipeDetailView.swift
//  FetchRecipeApp
//
//  Created by Jolomi Mebaghanje on 4/15/25.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let url = recipe.photoURLLarge {
                    AsyncImage(url: url) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .scaledToFit()
                    .cornerRadius(12)
                    .padding(.horizontal)
                }

                Text(recipe.name)
                    .font(.title)
                    .bold()
                    .padding(.horizontal)

                Text("Cuisine: \(recipe.cuisine)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)

                if let source = recipe.sourceURL {
                    Link("View Full Recipe", destination: source)
                        .padding(.horizontal)
                }

                if let youtube = recipe.youtubeURL {
                    Link("Watch on YouTube", destination: youtube)
                        .padding(.horizontal)
                }
            }
            .padding(.top)
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
