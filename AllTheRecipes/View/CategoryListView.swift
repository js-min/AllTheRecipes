//
//  CategoryListView.swift
//  AllTheRecipes
//
//  Created by JISU MIN on 2022/05/16.
//

import SwiftUI

struct CategoryListView: View {
  @StateObject var viewModel = CategoryListViewModel()
  
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      LazyHStack {
        ForEach(viewModel.categories, id:
                  \.title) { category in
          NavigationLink(destination: RecipeListView()) {
            Text(category.title)
              .foregroundColor(Color.white)
              .padding(.horizontal)
              .padding(.vertical, 5)
              .background(Color("AccentColor"))
              .clipShape(Capsule())
          }
            
        }
      }
    }
    .frame(height: 60)
    
  }
}

struct CategoryListView_Previews: PreviewProvider {
  static var previews: some View {
    CategoryListView()
      .previewLayout(.sizeThatFits)
  }
}
