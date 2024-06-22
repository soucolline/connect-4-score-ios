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
  private let color: Color
  
  init(playerName: String, color: Color) {
    self.playerName = playerName
    self.color = color
  }
  
  var body: some View {
    ZStack {
      GeometryReader { proxy in
        LinearGradient(gradient: Gradient(colors: [color, color]), startPoint: .bottom, endPoint: .top)
          .mask(
              VStack {
                  Spacer()
                  Rectangle()
                    .frame(height: CGFloat(score) / 5 * proxy.size.height + (score == 0 ? 0 : 10))
              }
          )
          .ignoresSafeArea()
      }
      
      VStack {
        Text(playerName)
          .font(.system(size: 40, design: .rounded))
        
        Text("\(score)")
          .font(.system(size: 100, weight: .black, design: .rounded))
          .contentTransition(.numericText())
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .contentShape(Rectangle())
    .ignoresSafeArea()
    .onTapGesture {
      guard score < 5 else { return }
      withAnimation(.bouncy) {
        score += 1
      }
    }
    .gesture(
      DragGesture(minimumDistance: 30, coordinateSpace: .local)
        .onEnded { value in
          if value.translation.width > 0 && abs(value.translation.height) < 30 {
            guard score > 0 else { return }
            withAnimation(.bouncy) {
              score -= 1
            }
          }
        }
    )
  }
}

#Preview {
  PanelView(playerName: "Thomas", color: .yellow)
}
