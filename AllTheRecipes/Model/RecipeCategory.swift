//
//  RecipeCategory.swift
//  AllTheRecipes
//
//  Created by JISU MIN on 2022/05/12.
//

import Foundation

struct CategoryResponse: Decodable {
  let categories: [RecipeCategory]
}


struct RecipeCategory: Decodable {
  let imageUrl: String
  let title: String
  var emoji: String {
    switch title {
    case "Chicken":
      return "🍗"
    case "Pizza":
      return "🍕"
    case "Breakfast":
      return "🍳"
    case "Bacon":
      return "🥓"
    case "Steak":
      return "🥩"
    case "Indian":
      return "🍛"
    case "Asian":
      return "🍚"
    default:
      return "🍽"
    }
  }
}
