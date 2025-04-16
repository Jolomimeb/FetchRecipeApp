//
//  Recipe.swift
//  FetchRecipeApp
//
//  Created by Jolomi Mebaghanje on 4/15/25.
//
// I use this file to define the data structure for a recipe object
import Foundation

// This is the struct that holds all the info for each recipe we get from the API
struct Recipe: Identifiable, Decodable, Equatable, Hashable {
    let id: UUID // unique id
    let name: String // name of the recipe
    let cuisine: String // cuisine type
    let photoURLSmall: URL? // small image for list
    let photoURLLarge: URL? // large image for detail view
    let sourceURL: URL? // original recipe website
    let youtubeURL: URL? // video tutorial link

    // Here I use CodingKeys to match the JSON keys from the API
    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case name
        case cuisine
        case photoURLSmall = "photo_url_small"
        case photoURLLarge = "photo_url_large"
        case sourceURL = "source_url"
        case youtubeURL = "youtube_url"
    }
}
