//
//  ContentView.swift
//  connect-4-score-ios
//
//  Created by Thomas Guilleminot on 22/06/2024.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    HStack(spacing: 0) {
      PanelView(playerName: "Thomas")
        .background(.white)
      
      Rectangle()
        .frame(width: 20)
        .frame(maxHeight: .infinity)
      
      PanelView(playerName: "Clara")
        .background(.white)
    }
  }
}

#Preview {
  ContentView()
}
