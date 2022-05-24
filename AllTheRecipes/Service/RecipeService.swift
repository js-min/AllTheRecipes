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
  func searchRecipes(query: String) -> AnyPublisher<[Recipe], ApiError>
  func getRecipe(id: Int) -> AnyPublisher<Recipe, ApiError>
}

struct RecipeService: RecipeServiceProtocol {
  func getCategories() -> AnyPublisher<[RecipeCategory], ApiError> {
    print(RecipeApi.getCategories.urlRequest)
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
    
//    return URLSession.shared
//      .dataTaskPublisher(for: RecipeApi.getCategories.urlRequest)
//      .receive(on: DispatchQueue.main)
//      .mapError { _ in ApiError.unknown }
//      .tryMap { data, response in
//        guard let response = response as? HTTPURLResponse else { throw ApiError.unknown }
//        guard (200..<300).contains(response.statusCode) else { throw ApiError.errorCode(response.statusCode)}
//        return data
//      }
//      .mapError { $0 as! ApiError }
//      .decode(type: CategoryResponse.self, decoder: JSONDecoder())
//      .mapError { _ in ApiError.decodingError }
//      .map(\.categories)
//      .eraseToAnyPublisher()
  }
  
  func searchRecipes(query: String) -> AnyPublisher<[Recipe], ApiError> {
    print(RecipeApi.searchRecipes(query: query).urlRequest)
    return URLSession.shared
      .dataTaskPublisher(for: RecipeApi.searchRecipes(query: query).urlRequest)
      .receive(on: DispatchQueue.main)
      .mapError { _ in ApiError.unknown }
      .flatMap { data, response -> AnyPublisher<[Recipe], ApiError> in
        guard let response = response as? HTTPURLResponse else {
          return Fail(error: ApiError.unknown).eraseToAnyPublisher()
        }
        if (200..<300).contains(response.statusCode) {
          return Just(data)
            .decode(type: SearchRecipeResponse.self, decoder: JSONDecoder())
            .mapError{ _ in ApiError.decodingError }
            .map(\.recipes)
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
