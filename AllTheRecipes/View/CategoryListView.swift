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
          Text(category.title)
            .foregroundColor(Color.white)
            .padding()
            .background(Color.blue)
            .clipShape(Capsule())
            
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
