//
//  GameViewModel.swift
//  MemoryGame
//
//  Created by Mark Gire on 10/31/21.
//

import Foundation

class GameViewModel: ObservableObject {
    @Published var TurnOptions = (computer: "computer",
                              user: "user",
                              tryAgain: "tryAgain",
                              win: "win");
    @Published var Turn = "computer"
    @Published var QuestionNumber = 0;
    @Published var AnswerNumber = 0;
    @Published var SelectedAnswer = String();
    @Published var SelectedQuestion = "black"
    @Published var QuestionSize = 100
    @Published var QuestionArr = [String]();
    
}
