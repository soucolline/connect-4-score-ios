//
//  GameViewModel.swift
//  connect-4-score-ios
//
//  Created by Thomas Guilleminot on 23/06/2024.
//

import Foundation
import SwiftUI

@Observable
public class GameViewModel {
  public enum Player {
    case player1
    case player2
  }
  
  public var player1Name = "Clara"
  public var player2Name = "Thomas"
  public var player1Color = Color.yellow
  public var player2Color = Color.red
  
  public var player1Score = 0 {
    willSet {
      checkScore(score: newValue, player: .player1)
    }
  }
  public var player2Score = 0 {
    willSet {
      checkScore(score: newValue, player: .player2)
    }
  }
  
  public var currentPlayer = Player.player1
  public var shouldShowWinnerAlert = false
  public var winner: Player?
  
  public func resetGame() {
    player1Score = 0
    player2Score = 0
    winner = nil
    shouldShowWinnerAlert = false
  }
  
  private func checkScore(score: Int, player: Player) {
    currentPlayer = switch currentPlayer {
    case .player1: .player2
    case .player2: .player1
    }
    
    if score >= 5 {
      winner = player
      shouldShowWinnerAlert = true
    }
  }
}
