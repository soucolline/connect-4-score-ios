//
//  PanelView.swift
//  connect-4-score-ios
//
//  Created by Thomas Guilleminot on 22/06/2024.
//

import SwiftUI

struct PanelView: View {
  @Binding public var score: Int
  
  private let playerName: String
  private let color: Color
  private let playersTurn: Bool
  private let numberOfRounds: Int
  private let onTap: (Int) -> Void
  
  init(
    playerName: String,
    color: Color,
    score: Binding<Int>,
    playersTurn: Bool,
    numberOfRounds: Int,
    onTap: @escaping (Int) -> Void
  ) {
    self.playerName = playerName
    self.color = color
    self._score = score
    self.playersTurn = playersTurn
    self.numberOfRounds = numberOfRounds
    self.onTap = onTap
  }
  
  var body: some View {
    ZStack {
      GeometryReader { proxy in
        LinearGradient(gradient: Gradient(colors: [color, color]), startPoint: .bottom, endPoint: .top)
          .mask(
            VStack {
              Spacer()
              Rectangle()
                .frame(height: CGFloat(score) / CGFloat(numberOfRounds) * proxy.size.height + (score == 0 ? 0 : 10))
            }
          )
          .ignoresSafeArea()
      }
      
      VStack {
        HStack {
          Text(playerName)
            .font(.system(size: 40, design: .rounded))
          
          if playersTurn {
            Image(systemName: "person.fill")
              .font(.system(size: 40))
          }
        }
        
        Text("\(score)")
          .font(.system(size: 100, weight: .black, design: .rounded))
          .contentTransition(.numericText())
      }
      .foregroundColor(.black)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .contentShape(Rectangle())
    .ignoresSafeArea()
    .onTapGesture {
      guard score < numberOfRounds else { return }
      onTap(score + 1)
    }
    .gesture(
      DragGesture(minimumDistance: 30, coordinateSpace: .local)
        .onEnded { value in
          if value.translation.width > 0 && abs(value.translation.height) < 30 {
            guard score > 0 else { return }
            onTap(score - 1)
          }
        }
    )
  }
}

#Preview {
  PanelView(
    playerName: "Thomas",
    color: .yellow,
    score: .constant(2),
    playersTurn: true,
    numberOfRounds: 5,
    onTap: { _ in }
  )
}
