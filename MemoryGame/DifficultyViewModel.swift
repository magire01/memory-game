//
//  DifficultyViewModel.swift
//  MemoryGame
//
//  Created by Mark Gire on 10/31/21.
//

import Foundation
import SwiftUI

class DifficultyViewModel: ObservableObject {
    
    struct GameDifficulty {
        var difficulty: String
        var colorOptions: [String]
    }
    
    @Published var EasyMode = (GameDifficulty(difficulty: "easy",
                                                colorOptions: ["blue", "red", "purple"]))
    @Published var MediumMode = (GameDifficulty(difficulty: "medium",
                                                colorOptions: ["blue", "red", "purple", "yellow"]))
    @Published var HardMode = (GameDifficulty(difficulty: "hard",
                                                colorOptions: ["blue", "red", "purple", "yellow", "green"]))
}
