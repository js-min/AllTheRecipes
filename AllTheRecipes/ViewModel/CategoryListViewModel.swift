//
//  CategoryListViewModel.swift
//  AllTheRecipes
//
//  Created by JISU MIN on 2022/05/16.
//

import Foundation
import Combine

class CategoryListViewModel: ObservableObject {
  private let service = RecipeService()
  private var cancellable: AnyCancellable?
  
  @Published var categories: [RecipeCategory] = []
  
  init() {
    getCategories()
  }
  
  func getCategories() {
    cancellable = service.getCategories()
      .sink { completion in
        switch completion {
        case .failure(let error):
          print("DEBUG: got error \(error.localizedDescription)")
        case .finished:
          print("DEBUG: finished to get categories")
        }
      } receiveValue: { [weak self] categories in
        self?.categories = categories
      }
  }
}
