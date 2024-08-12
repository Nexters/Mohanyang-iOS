//
//  ContentView.swift
//  HomeFeature
//
//  Created by devMinseok on 8/10/24.
//

import SwiftUI

import HomeFeature

struct ContentView: View {
  var body: some View {
    NavigationStack {
      List {
        NavigationLink {
          HomeView(
            store: .init(
              initialState: .init(),
              reducer: { HomeCore() }
            )
          )
        } label: {
          Text("Home")
        }
      }
    }
  }
}

#Preview {
  ContentView()
}
