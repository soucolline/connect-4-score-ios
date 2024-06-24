//
//  PlayerColor.swift
//  connect-4-score-ios
//
//  Created by Thomas Guilleminot on 23/06/2024.
//

import Foundation
import SwiftUI

enum PlayerColor: CaseIterable {
  case yellow
  case red
  
  var title: String {
    switch self {
    case .yellow: "Yellow"
    case .red: "Red"
    }
  }
  
  var color: Color {
    switch self {
    case .yellow: .yellow
    case .red: .red
    }
  }
  
  static func initFromString(value: String) -> PlayerColor {
    if value == "Yellow" {
      return .yellow
    } else if value == "Red" {
      return .red
    } else {
      return .yellow
    }
  }
}
