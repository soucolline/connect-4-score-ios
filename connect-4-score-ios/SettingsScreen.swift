//
//  SettingsView.swift
//  connect-4-score-ios
//
//  Created by Thomas Guilleminot on 23/06/2024.
//

import SwiftUI

struct SettingsScreen: View {
  @AppStorage("player1Name") var player1Name: String = "Player 1"
  @AppStorage("player2Name") var player2Name: String = "Player 2"
  @AppStorage("player1Color") var player1Color: String = "Yellow"
  @AppStorage("player2Color") var player2Color: String = "Red"
  @AppStorage("numberOfRounds") var numberOfRounds: Int = 5
  
  let didTapSaveButton: () -> Void
  
  init(didTapSaveButton: @escaping () -> Void) {
    self.didTapSaveButton = didTapSaveButton
  }
  
  var body: some View {
    NavigationStack {
      Form {
        Section {
          TextField("Player 1 name", text: $player1Name)
          Picker("Player 1 color", selection: $player1Color) {
            ForEach(PlayerColor.allCases, id: \.self) {
              Text($0.title).tag($0.title)
            }
          }
        } header: {
          Text("Player 1")
        }
        
        Section {
          TextField("Player 2 name", text: $player2Name)
          Picker("Player 2 color", selection: $player2Color) {
            ForEach(PlayerColor.allCases, id: \.self) {
              Text($0.title).tag($0.title)
            }
          }
        } header: {
          Text("Player 2")
        }
        
        Section {
          Stepper("Number of rounds : \(numberOfRounds)", value: $numberOfRounds, in: 0...20)
        } header: {
          Text("Game settings")
        }
        
        Section {
          Button("Save") {
            didTapSaveButton()
          }
        }
      }
      .navigationTitle("Settings")
    }
  }
}

#Preview {
  SettingsScreen(
    didTapSaveButton: {}
  )
}
