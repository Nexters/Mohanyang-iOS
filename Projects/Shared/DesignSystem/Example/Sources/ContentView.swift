//
//  ContentView.swift
//  DesignSystem
//
//  Created by devMinseok on 8/5/24.
//

import SwiftUI

import DesignSystem

struct ContentView: View {
  var body: some View {
    NavigationStack {
      List {
        Section("Typography") {
          NavigationLink {
            FontDetailView()
          } label: {
            Text("Font")
          }
        }
        
        Section("Token") {
          NavigationLink {
            GlobalTokenDetailView()
          } label: {
            Text("Global")
          }
          
          NavigationLink {
            AliasTokenDetailView()
          } label: {
            Text("Alias")
          }
        }
        
        Section("Component") {
          NavigationLink {
            
          } label: {
            Text("Button")
          }
          
          NavigationLink {
            
          } label: {
            Text("Tooltip")
          }
          
          NavigationLink {
            
          } label: {
            Text("BottomSheet")
          }
          
          NavigationLink {
            
          } label: {
            Text("Dialog")
          }
          
          NavigationLink {
            
          } label: {
            Text("Toast")
          }
          
          NavigationLink {
            
          } label: {
            Text("System")
          }
          
          NavigationLink {
            
          } label: {
            Text("List")
          }
        }
      }
      .navigationTitle("DesignSystem")
    }
  }
}

#Preview {
  ContentView()
}
