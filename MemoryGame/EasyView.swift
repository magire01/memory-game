//
//  GameView.swift
//  MemoryGame
//
//  Created by Mark Gire on 10/26/21.
//

import SwiftUI

struct EasyView: View {
    
    //DifficultyViewModel
    @ObservedObject var Difficulty = DifficultyViewModel();
    
    //GameViewModel
    @ObservedObject var GameModel = GameViewModel();
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func setQuestion() {
        if (GameModel.MaxQuestions == 2) {
            for index in 0...GameModel.MaxQuestions {
                var randomNumber = Int.random(in: 0..<3)
                if(index > 0) {
                    while(GameModel.QuestionArr[index - 1] == Difficulty.EasyMode.colorOptions[randomNumber]) {
                        randomNumber = Int.random(in: 0..<3)
                    }
                }
                GameModel.QuestionArr.append(Difficulty.EasyMode.colorOptions[randomNumber])
            }
        } else {
            var randomNumber = Int.random(in: 0..<3)
            
            while(GameModel.QuestionArr[GameModel.QuestionArr.count - 1] == Difficulty.EasyMode.colorOptions[randomNumber]) {
                randomNumber = Int.random(in: 0..<3)
            }
            
            GameModel.QuestionArr.append(Difficulty.EasyMode.colorOptions[randomNumber])
        }
        print(GameModel.QuestionArr)
        GameModel.SelectedQuestion = GameModel.QuestionArr[0]
    }
    
    func displayAnswerSelect() -> some View {
        HStack(spacing: 10) {
            ForEach(Difficulty.EasyMode.colorOptions, id: \.self) {num in
                Button(action: {
                    GameModel.SelectedAnswer = num;
                    if (GameModel.SelectedAnswer == GameModel.QuestionArr[GameModel.AnswerNumber]) {
                        GameModel.AnswerNumber = GameModel.AnswerNumber + 1;
                        if (GameModel.AnswerNumber == GameModel.QuestionArr.count) {
                            GameModel.Turn = GameModel.TurnOptions.win
                        }
                    } else {
                        GameModel.Turn = GameModel.TurnOptions.tryAgain
                    }
                },
                       label: {
                    switch(num) {
                    case "red":
                        Text("        ")
                            .background(Color.red)
                            .padding(15)
                            .font(.system(size: 30.0))
                    case "blue":
                        Text("        ")
                            .background(Color.blue)
                            .padding(15)
                            .font(.system(size: 30.0))
                    default:
                        Text("        ")
                            .background(Color.purple)
                            .padding(15)
                            .font(.system(size: 30.0))
                    }
                })
            }
        }
    }
    
    func displayQuestion() -> some View {
        return VStack{
            switch (GameModel.SelectedQuestion) {
            case "red":
                Rectangle()
                    .foregroundColor(Color.red)
                    .padding(15)
                    .frame(width: CGFloat(GameModel.QuestionSize), height: CGFloat(120))
                    .onAppear {
                        withAnimation {
                            GameModel.QuestionSize += 50;
                        }
                    }
                    .onDisappear {
                        GameModel.QuestionSize = 120;
                    }
            case "blue":
                Rectangle()
                    .foregroundColor(Color.blue)
                    .padding(15)
                    .frame(width: CGFloat(GameModel.QuestionSize), height: CGFloat(120))
                    .onAppear {
                        withAnimation {
                            GameModel.QuestionSize += 50;
                        }
                    }
                    .onDisappear {
                        GameModel.QuestionSize = 120;
                    }
            case "purple":
                Rectangle()
                    .foregroundColor(Color.purple)
                    .padding(15)
                    .frame(width: CGFloat(GameModel.QuestionSize), height: CGFloat(120))
                    .onAppear {
                        withAnimation {
                            GameModel.QuestionSize += 50;
                        }
                    }
                    .onDisappear {
                        GameModel.QuestionSize = 120;
                    }
            default:
                Rectangle()
                    .background(Color.white)
                    .padding(15)
                    .frame(width: CGFloat(GameModel.QuestionSize), height: CGFloat(120))
                    .onAppear {
                        withAnimation {
                            GameModel.QuestionSize += 50;
                        }
                    }
                    .onDisappear {
                        GameModel.QuestionSize = 120;
                    }
            }
        }
    }
    
    func displayTimer() -> some View {
        return Text("")
            .onAppear {
                setQuestion();
            }
            .onReceive(timer) { _ in
                if GameModel.TimeRemaining > 0 {
                    GameModel.TimeRemaining -= 1
                    GameModel.QuestionNumber = GameModel.QuestionNumber + 1
                    GameModel.SelectedQuestion = GameModel.QuestionArr[GameModel.QuestionNumber];
                } else {
                    GameModel.Turn = GameModel.TurnOptions.user;
                }
            }
    }
    
    func displayTryAgain() -> some View {
        VStack {
            Button("Start Over", action: {
                GameModel.ResetGame();
            })
                .background(Color(red: 0.8, green: 0, blue: 0))
                .padding(10)
                .foregroundColor(Color.white)
                .font(.system(size: 20))
        }
        .background(Color(red: 0.8, green: 0, blue: 0))
        .frame(width: 150, height: 100)
    }
    
    func displayWin() -> some View {
        VStack {
            Button("Continue", action: {
                GameModel.NextLevel();
            })
                .background(Color(red: 0, green: 0.5, blue: 0))
                .padding(10)
                .foregroundColor(Color.white)
                .font(.system(size: 20))
        }
        .background(Color(red: 0, green: 0.5, blue: 0))
        .frame(width: 100, height: 100)
    }

    
    var body: some View {
        switch (GameModel.Turn) {
        case GameModel.TurnOptions.user:
            displayAnswerSelect();
            Spacer();
        case GameModel.TurnOptions.tryAgain:
            displayTryAgain();
            Spacer();
        case GameModel.TurnOptions.win:
            displayWin();
            Spacer();
        default:
            displayTimer();
            displayQuestion();
            Spacer();
            Spacer();
            
        }
        VStack {
            Text("Level \(GameModel.MaxQuestions - 1)")
                .padding(10)
                .background(Color.white)
                .foregroundColor(Color(red: 0, green: 0.5, blue: 1))
                .font(.system(size: 20.0))
                .border(Color(red: 0, green: 0.5, blue: 1))
                
        }
    }
}
