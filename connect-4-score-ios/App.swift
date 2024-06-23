//
//  connect_4_score_iosApp.swift
//  connect-4-score-ios
//
//  Created by Thomas Guilleminot on 22/06/2024.
//

import SwiftUI

@main
struct connect_4_score_iosApp: App {
  var body: some Scene {
    WindowGroup {
      GameView(viewModel: GameViewModel())
    }
  }
}
