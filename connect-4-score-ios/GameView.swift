//
//  ContentView.swift
//  connect-4-score-ios
//
//  Created by Thomas Guilleminot on 22/06/2024.
//

import SwiftUI

struct GameView: View {
  @Bindable private var viewModel: GameViewModel
  
  init(viewModel: GameViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    HStack(spacing: 0) {
      PanelView(
        playerName: viewModel.player1Name,
        color: viewModel.player1Color,
        score: $viewModel.player1Score,
        playersTurn: viewModel.currentPlayer == .player1
      )
      .background(.white)
      
      Rectangle()
        .fill(.black)
        .frame(width: 20)
        .frame(maxHeight: .infinity)
        .ignoresSafeArea()
      
      PanelView(
        playerName: viewModel.player2Name,
        color: viewModel.player2Color,
        score: $viewModel.player2Score,
        playersTurn: viewModel.currentPlayer == .player2
      )
      .background(.white)
    }
    .alert(isPresented: $viewModel.shouldShowWinnerAlert) {
      let playerName = switch viewModel.winner {
      case .player1: viewModel.player1Name
      case .player2: viewModel.player2Name
      case .none: ""
      }
      
      return Alert(
        title: Text("Winner"),
        message: Text("\(playerName) won"),
        dismissButton: .default(Text("Replay"), action: { viewModel.resetGame() })
      )
    }
  }
}

#Preview {
  GameView(
    viewModel: GameViewModel()
  )
}
