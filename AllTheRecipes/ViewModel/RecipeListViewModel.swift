//
//  RecipeListViewModel.swift
//  AllTheRecipes
//
//  Created by JISU MIN on 2022/05/25.
//

import Foundation
import Combine

class RecipeListViewModel: ObservableObject {
  private let service = RecipeService()
  private var cancellable: AnyCancellable?
  
  @Published var recipeList: [Recipe] = []
  
  func getRecipes(category: String) {
    cancellable = service.searchRecipes(query: category)
      .sink { completion in
        switch completion {
        case .failure(let error):
          print("DEBUG: got error \(error.localizedDescription)")
        case .finished:
          print("DEBUG: finished to get categories")
        }
      } receiveValue: { [weak self] recipeList in
        self?.recipeList = recipeList
      }
  }
}
