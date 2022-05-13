//
//  ApiError.swift
//  AllTheRecipes
//
//  Created by JISU MIN on 2022/05/13.
//

import Foundation

enum ApiError {
  case decodingError
  case errorCode(Int)
  case unknown
}

extension ApiError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .decodingError:
      return "Failed to decode."
    case .errorCode(let errorCode):
      return "\(errorCode) - Something went wrong"
    case .unknown:
      return "The error is unknown"
    }
  }
}
