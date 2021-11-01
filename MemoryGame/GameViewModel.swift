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
    @Published var QuestionSize = 120
    @Published var QuestionArr = [String]();
    @Published var MaxQuestions = 2
    @Published var TimeRemaining = 2
    
    func ResetGame() {
        print("test")
        Turn = "computer"
        QuestionNumber = 0
        AnswerNumber = 0
        SelectedAnswer = String()
        SelectedQuestion = "black"
        QuestionSize = 120
        QuestionArr = [String]()
        MaxQuestions = 2
        TimeRemaining = 2
    }
    
    func NextLevel() {
        Turn = "computer"
        QuestionNumber = 0
        AnswerNumber = 0
        SelectedAnswer = String()
        SelectedQuestion = "black"
        QuestionSize = 120
        TimeRemaining = MaxQuestions + 1
        MaxQuestions = MaxQuestions + 1
        print("Level \(MaxQuestions)")
    }
}
