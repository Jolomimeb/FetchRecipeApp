//
//  RecipeRow.swift
//  FetchRecipeApp
//
//  Created by Jolomi Mebaghanje on 4/15/25.
//

import SwiftUI

struct RecipeRow: View {
    let recipe: Recipe
    @State private var image: UIImage?
    @EnvironmentObject var viewModel: RecipeViewModel

    var body: some View {
        HStack(spacing: 12) {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipped()
                    .cornerRadius(10)
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 80, height: 80)
                    .cornerRadius(10)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.name).font(.headline)
                Text(recipe.cuisine).font(.subheadline).foregroundColor(.secondary)
            }

            Spacer()

            Button(action: {
                viewModel.toggleSaved(recipe)
            }) {
                Image(systemName: viewModel.isSaved(recipe) ? "heart.fill" : "heart")
                    .foregroundColor(.red)
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 8)
        .task {
            if let url = recipe.photoURLSmall {
                image = await ImageCache.shared.image(for: url)
            }
        }
    }
}
