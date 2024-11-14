import SwiftUI

import ErrorFeature

struct ContentView: View {
  @State var isNetworkErrorViewPresented = false
  @State var isRequestErrorViewPresented = false
  
  var body: some View {
    VStack(spacing: 20) {
      Spacer()

      Button(title: "네트워크 에러 뷰") {
        isNetworkErrorViewPresented = true
      }

      Button(title: "서버통신 에러 뷰") {
        isRequestErrorViewPresented = true
      }

      Spacer()
    }
    .fullScreenCover(isPresented: $isNetworkErrorViewPresented) {
      NetworkErrorView()
    }
    .fullScreenCover(isPresented: $isRequestErrorViewPresented) {
      RequestErrorView()
    }
  }
}

#Preview {
  ContentView()
}
