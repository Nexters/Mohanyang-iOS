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
            ButtonDetailView()
          } label: {
            Text("Button")
          }
          
          NavigationLink {
            NavigationDetailView()
          } label: {
            Text("Navigation")
          }
          
          NavigationLink {
            TooltipDetailView()
          } label: {
            Text("Tooltip")
          }
          
          NavigationLink {
            BottomSheetDetailView()
          } label: {
            Text("BottomSheet")
          }
          
          NavigationLink {
            ToastDetailView()
          } label: {
            Text("Toast")
          }
          
          NavigationLink {
            DialogDetailView()
          } label: {
            Text("Dialog")
          }

          NavigationLink {
            InputFieldDetailView()
          } label: {
            Text("InputField")
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
