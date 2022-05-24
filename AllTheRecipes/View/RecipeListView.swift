//
//  RecipeListView.swift
//  AllTheRecipes
//
//  Created by JISU MIN on 2022/05/16.
//

import SwiftUI

struct RecipeListView: View {
  let category: String
  @StateObject private var viewModel = RecipeListViewModel()
  
  var body: some View {
    NavigationView {
      ScrollView {
        LazyVStack {
          ForEach(viewModel.recipeList, id:
                    \.title) { recipe in
            HStack {
              AsyncImage(url: URL(string: recipe.imageUrl))  { image in
                image.resizable()
              } placeholder: {
                ProgressView()
              }
              .frame(width: 50, height: 50)
              Text(recipe.title)
                .font(.body)
              Spacer()
            }
            .padding()
          }
        }
      }
    }
    .navigationTitle(category)
    .onAppear {
      viewModel.getRecipes(category: category)
    }
  }
}

struct RecipeListView_Previews: PreviewProvider {
  static var previews: some View {
    RecipeListView(category: "chicken")
  }
}
