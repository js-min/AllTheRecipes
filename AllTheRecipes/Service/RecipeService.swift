//
//  RecipeService.swift
//  AllTheRecipes
//
//  Created by JISU MIN on 2022/05/13.
//

import Foundation
import Combine

protocol RecipeServiceProtocol {
  func getCategories() -> AnyPublisher<[RecipeCategory], ApiError>
  func searchRecipes(query: String) -> AnyPublisher<SearchRecipeResponse, ApiError>
  func getRecipe(id: Int) -> AnyPublisher<Recipe, ApiError>
}

struct RecipeService: RecipeServiceProtocol {
  func getCategories() -> AnyPublisher<[RecipeCategory], ApiError> {
    return URLSession.shared
      .dataTaskPublisher(for: RecipeApi.getCategories.urlRequest)
      .receive(on: DispatchQueue.main)
      .mapError { _ in ApiError.unknown }
      .flatMap { data, response -> AnyPublisher<[RecipeCategory], ApiError> in
        guard let response = response as? HTTPURLResponse else {
          return Fail(error: ApiError.unknown).eraseToAnyPublisher()
        }
        if (200..<300).contains(response.statusCode) {
          return Just(data)
            .decode(type: CategoryResponse.self, decoder: JSONDecoder())
            .mapError{ _ in ApiError.decodingError }
            .map(\.categories)
            .eraseToAnyPublisher()
        } else {
          return Fail(error: ApiError.errorCode(response.statusCode)).eraseToAnyPublisher()
        }
      }
      .eraseToAnyPublisher()
  }
  
  func searchRecipes(query: String) -> AnyPublisher<SearchRecipeResponse, ApiError> {
    return URLSession.shared
      .dataTaskPublisher(for: RecipeApi.searchRecipes(query: query).urlRequest)
      .receive(on: DispatchQueue.main)
      .mapError { _ in ApiError.unknown }
      .flatMap { data, response -> AnyPublisher<SearchRecipeResponse, ApiError> in
        guard let response = response as? HTTPURLResponse else {
          return Fail(error: ApiError.unknown).eraseToAnyPublisher()
        }
        if (200..<300).contains(response.statusCode) {
          return Just(data)
            .decode(type: SearchRecipeResponse.self, decoder: JSONDecoder())
            .mapError{ _ in ApiError.decodingError }
            .eraseToAnyPublisher()
        } else {
          return Fail(error: ApiError.errorCode(response.statusCode)).eraseToAnyPublisher()
        }
      }
      .eraseToAnyPublisher()
  }
  
  func getRecipe(id: Int) -> AnyPublisher<Recipe, ApiError> {
    return URLSession.shared
      .dataTaskPublisher(for: RecipeApi.getRecipe(id: id).urlRequest)
      .receive(on: DispatchQueue.main)
      .mapError { _ in ApiError.unknown }
      .flatMap { data, response -> AnyPublisher<Recipe, ApiError> in
        guard let response = response as? HTTPURLResponse else {
          return Fail(error: ApiError.unknown).eraseToAnyPublisher()
        }
        if (200..<300).contains(response.statusCode) {
          return Just(data)
            .decode(type: RecipeDetailResponse.self, decoder: JSONDecoder())
            .mapError{ _ in ApiError.decodingError }
            .map(\.recipe)
            .eraseToAnyPublisher()
        } else {
          return Fail(error: ApiError.errorCode(response.statusCode)).eraseToAnyPublisher()
        }
      }
      .eraseToAnyPublisher()
  }
  
  
}
