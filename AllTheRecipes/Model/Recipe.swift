//
//  Recipe.swift
//  AllTheRecipes
//
//  Created by JISU MIN on 2022/05/13.
//

import Foundation

struct SearchRecipeResponse: Decodable {
  let count: Int
  let recipes: [Recipe]
}

struct RecipeDetailResponse: Decodable {
  let recipe: Recipe
}

struct Recipe: Decodable {
  let imageUrl: String
  let socialUrl: Double
  let publisher: String
  let sourceUrl: String
  let publishedId: String
  let title: String
  let ingredients: [String]?
}
