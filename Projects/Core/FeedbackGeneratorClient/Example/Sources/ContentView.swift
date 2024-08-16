//
//  ContentView.swift
//  FeedbackGeneratorClient
//
//  Created by devMinseok on 8/16/24.
//

import SwiftUI

import Dependencies
import FeedbackGeneratorClientInterface

struct ContentView: View {
  @Dependency(FeedbackGeneratorClient.self) var feedbackGeneratorClient
  
  var body: some View {
    NavigationStack {
      List {
        Button {
          Task {
            await feedbackGeneratorClient.impactOccurred(.heavy)
          }
        } label: {
          Text("impactOccurred: heavy")
        }
        
        Button {
          Task {
            await feedbackGeneratorClient.impactOccurred(.light)
          }
        } label: {
          Text("impactOccurred: light")
        }
        
        Button {
          Task {
            await feedbackGeneratorClient.impactOccurred(.medium)
          }
        } label: {
          Text("impactOccurred: medium")
        }
        
        Button {
          Task {
            await feedbackGeneratorClient.impactOccurred(.rigid)
          }
        } label: {
          Text("impactOccurred: rigid")
        }
        
        Button {
          Task {
            await feedbackGeneratorClient.impactOccurred(.soft)
          }
        } label: {
          Text("impactOccurred: soft")
        }
        
        Button {
          Task {
            await feedbackGeneratorClient.notification(.error)
          }
        } label: {
          Text("notification: error")
        }
        
        Button {
          Task {
            await feedbackGeneratorClient.notification(.success)
          }
        } label: {
          Text("notification: success")
        }
        
        Button {
          Task {
            await feedbackGeneratorClient.notification(.warning)
          }
        } label: {
          Text("notification: warning")
        }
        
        Button {
          Task {
            await feedbackGeneratorClient.selectionChanged()
          }
        } label: {
          Text("selectionChanged")
        }
      }
      .navigationTitle("FeedbackGenerator")
    }
  }
}

#Preview {
  ContentView()
}
