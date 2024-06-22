//
//  PanelView.swift
//  connect-4-score-ios
//
//  Created by Thomas Guilleminot on 22/06/2024.
//

import SwiftUI

struct PanelView: View {
  @State private var score: Int = 0
  
  private let playerName: String
  
  init(playerName: String) {
    self.playerName = playerName
  }
  
  var body: some View {
    VStack {
      Text(playerName)
        .font(.system(size: 40, design: .rounded))
      
      Text("\(score)")
        .font(.system(size: 100, weight: .black, design: .rounded))
        .contentTransition(.numericText())
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .contentShape(Rectangle())
    .onTapGesture {
      withAnimation {
        score += 1
      }
    }
    .gesture(
      DragGesture(minimumDistance: 30, coordinateSpace: .local)
        .onEnded { value in
          if value.translation.width > 0 && abs(value.translation.height) < 30 {
            withAnimation {
              score -= 1
            }
          }
        }
    )
  }
}

#Preview {
  PanelView(playerName: "Thomas")
}
