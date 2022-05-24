//
//  CategoryVerticalListView.swift
//  AllTheRecipes
//
//  Created by JISU MIN on 2022/05/16.
//

import SwiftUI

struct CategoryVerticalListView: View {
  @StateObject var viewModel = CategoryListViewModel()
  
  var body: some View {
    ForEach(viewModel.categories, id:
              \.title) { category in
      NavigationLink(destination: RecipeListView(category: category.title)) {
        HStack {
          Text(category.emoji)
            .font(.title2)
          Text(category.title)
            .font(.body)
          Spacer()
        }
        .padding()
      }
    }
    
  }
}

struct CategoryVerticalListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryVerticalListView()
    }
}
