//
//  ContentView.swift
//  connect-4-score-ios
//
//  Created by Thomas Guilleminot on 22/06/2024.
//

import SwiftUI

// TODO: move elsewhere
public enum Player {
  case player1
  case player2
}

struct GameScreen: View {
  @AppStorage("player1Name") var player1Name: String = "Player 1"
  @AppStorage("player2Name") var player2Name: String = "Player 2"
  @AppStorage("player1Color") var player1Color: String = "Yellow"
  @AppStorage("player2Color") var player2Color: String = "Red"
  @AppStorage("numberOfRounds") var numberOfRounds: Int = 5
  
  @State private var currentPlayer = Player.player1
  @State private var shouldShowWinnerAlert = false
  @State private var shouldShowSettings = false
  @State private var winner: Player?
  
  @State private var player1Score = 0
  @State private var player2Score = 0
  
  init() {}
  
  var body: some View {
    NavigationStack {
      ZStack {
        HStack(spacing: 0) {
          PanelView(
            playerName: player1Name,
            color: PlayerColor.initFromString(value: player1Color).color,
            score: $player1Score,
            playersTurn: currentPlayer == .player1,
            numberOfRounds: numberOfRounds,
            onTap: { newValue in
              withAnimation(.bouncy) {
                player1Score = newValue
              }
              checkScore(score: newValue, player: .player1)
            }
          )
          .background(.white)
          
          Rectangle()
            .fill(.black)
            .frame(width: 20)
            .frame(maxHeight: .infinity)
            .ignoresSafeArea()
          
          PanelView(
            playerName: player2Name,
            color: PlayerColor.initFromString(value: player2Color).color,
            score: $player2Score,
            playersTurn: currentPlayer == .player2,
            numberOfRounds: numberOfRounds,
            onTap: { newValue in
              withAnimation(.bouncy) {
                player2Score = newValue
              }
              checkScore(score: newValue, player: .player2)
            }
          )
          .background(.white)
        }
      }
      .alert(isPresented: $shouldShowWinnerAlert) {
        let playerName = switch winner {
        case .player1: player1Name
        case .player2: player2Name
        case .none: ""
        }
        
        return Alert(
          title: Text("Winner"),
          message: Text("\(playerName) won"),
          dismissButton: .default(Text("Replay"), action: {
            withAnimation {
              resetGame()
            }
          })
        )
      }
      .toolbar {
        Button(action: {
          shouldShowSettings = true
        }, label: {
          Image(systemName: "gearshape.fill")
            .foregroundColor(.black)
        })
      }
    }
    .sheet(isPresented: $shouldShowSettings) {
      SettingsScreen(
        didTapSaveButton: {
          shouldShowSettings = false
        }
      )
    }
  }
  
  private func checkScore(score: Int, player: Player) {
    currentPlayer = switch currentPlayer {
    case .player1: .player2
    case .player2: .player1
    }
    
    if score >= numberOfRounds {
      winner = player
      
      Task {
        try await Task.sleep(nanoseconds: 500_000_000)
        shouldShowWinnerAlert = true
      }
    }
  }
  
  private func resetGame() {
    player1Score = 0
    player2Score = 0
    winner = nil
    shouldShowWinnerAlert = false
  }
}

#Preview {
  GameScreen()
}
