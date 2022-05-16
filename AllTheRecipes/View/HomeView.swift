//
//  HomeView.swift
//  AllTheRecipes
//
//  Created by JISU MIN on 2022/05/16.
//

import SwiftUI

struct HomeView: View {
  @State var searchTerm: String = ""
  
  var body: some View {
    NavigationView {
      VStack(alignment: .leading) {
        Text("What do you want to cook?")
          .padding()
        
        HStack {
          Image(systemName: "magnifyingglass")
            .frame(width: 20, height: 20)
          TextField("Search recipes", text: $searchTerm)
        }
          .padding(.vertical, 10)
          .padding(.horizontal, 10)
          .foregroundColor(Color.gray)
          .background(Color("SecondaryColor"))
          .cornerRadius(10)
          .padding(.horizontal, 10)
          
        Text("Category")
          .font(.title2)
          .bold()
          .padding()
        CategoryVerticalListView()
        Spacer()
      }
      .foregroundColor(Color("AccentColor"))
      .navigationTitle("Hi, Yeppi")
    }
    
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
