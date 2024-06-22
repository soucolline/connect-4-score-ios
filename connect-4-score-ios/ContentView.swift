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
      PanelView(playerName: "Clara", color: .yellow)
        .background(.white)
      
      Rectangle()
        .frame(width: 20)
        .frame(maxHeight: .infinity)
        .ignoresSafeArea()
      
      PanelView(playerName: "Thomas", color: .red)
        .background(.white)
    }
  }
}

#Preview {
  ContentView()
}
