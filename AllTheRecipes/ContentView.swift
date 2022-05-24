//
//  ContentView.swift
//  AllTheRecipes
//
//  Created by JISU MIN on 2022/05/12.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationView {
      HomeView()
    }
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarTitle("All The Recipes!")
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
