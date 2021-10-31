//
//  GameViewModel.swift
//  MemoryGame
//
//  Created by Mark Gire on 10/31/21.
//

import Foundation

class GameViewModel: ObservableObject {
    struct GameDifficulty {
        var computer: String
        var user: String
        var tryAgain: String
        var win: String
    }
    @Published var UserTurn = (GameDifficulty(computer: "computer",
                                              user: "user",
                                              tryAgain: "tryAgain",
                                              win: "win"));
    
}
