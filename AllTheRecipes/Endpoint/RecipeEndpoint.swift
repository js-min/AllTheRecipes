//
//  RecipeEndpoint.swift
//  AllTheRecipes
//
//  Created by JISU MIN on 2022/05/12.
//

import Foundation

protocol ApiBuilder {
  var urlRequest: URLRequest { get }
  var baseUrl: URL { get }
  var path: String { get }
}

enum RecipeApi {
  case getCategories
  case searchRecipes(query: String)
  case getRecipe(id: Int)
}


extension RecipeApi: ApiBuilder {
  var urlRequest: URLRequest {
    switch self {
    case.searchRecipes(let query):
      var urlComponents = URLComponents(string: "https://recipesapi.herokuapp.com/api/v2/recipes")!
      urlComponents.queryItems = [URLQueryItem(name: "q", value: query), URLQueryItem(name: "page", value: "1")]
      return URLRequest(url: urlComponents.url!)
    default:
      return URLRequest(url: baseUrl.appendingPathComponent(path))
    }
  }
  
  var baseUrl: URL {
    return URL(string: "https://recipesapi.herokuapp.com/api/v2")!
  }
  
  var path: String {
    switch self {
    case .getCategories:
      return "/categories"
    case .searchRecipes(let query):
      return "/recipes?q=\(query)&page=1"
    case .getRecipe(let rId):
      return "/recipes/\(rId)"
    }
  }
}
