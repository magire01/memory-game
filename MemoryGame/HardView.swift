//
//  HardView.swift
//  MemoryGame
//
//  Created by Mark Gire on 10/31/21.
//

import SwiftUI

struct HardView: View {
    @State var gameTurn = "computer";
    @State var isCorrect = Bool();
    @State var qNumber = 0;
    @State var aNumber = 0;
    @State var qDisplay = "black"
    @State var qSize = 120;
    @State var showQDisplay = false;
    
    //DifficultyViewModel
    @ObservedObject var Difficulty = DifficultyViewModel();
    
    @State var questionArr = [String]()
    
    @State var answer = [Bool]();
    @State var selectedAnswer = String();
    @State var numberOfQuestions = 2;
    @State var timeRemaining = 2;
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    func setQuestion() {
        if (numberOfQuestions == 2) {
            for index in 0...numberOfQuestions {
                var randomNumber = Int.random(in: 0..<5)
                if(index > 0) {
                    while(questionArr[index - 1] == Difficulty.HardMode.colorOptions[randomNumber]) {
                        randomNumber = Int.random(in: 0..<5)
                    }
                }
                questionArr.append(Difficulty.HardMode.colorOptions[randomNumber])
            }
        } else {
            var randomNumber = Int.random(in: 0..<5)
            
            while(questionArr[questionArr.count - 1] == Difficulty.HardMode.colorOptions[randomNumber]) {
                randomNumber = Int.random(in: 0..<5)
            }
            
            questionArr.append(Difficulty.HardMode.colorOptions[randomNumber])
        }
        print(questionArr)
        qDisplay = questionArr[0]
    }
    
    func resetGame() {
        gameTurn = "computer";
        isCorrect = Bool();
        qNumber = 0;
        aNumber = 0;
        timeRemaining = 2
        numberOfQuestions = 2
        answer = [Bool]();
        selectedAnswer = String();
        questionArr = [String]();
        qSize = 120;
    }
    
    func nextLevel() {
        timeRemaining = numberOfQuestions + 1;
        numberOfQuestions = numberOfQuestions + 1;
        gameTurn = "computer";
        isCorrect = Bool();
        qNumber = 0;
        aNumber = 0;
        answer = [Bool]();
        selectedAnswer = String();
        qSize = 100;
        print("Level \(numberOfQuestions)")
    }
    
    func displayAnswerSelect() -> some View {
        VStack {
            HStack(spacing: 10) {
                ForEach(Difficulty.HardMode.colorOptions[0...2], id: \.self) {num in
                    Button(action: {
                        selectedAnswer = num;
                        if (selectedAnswer == questionArr[aNumber]) {
                            answer.append(true)
                            aNumber = aNumber + 1;
                            if (aNumber == questionArr.count) {
                                gameTurn = "win"
                            }
                        } else {
                            answer.append(false)
                            gameTurn = "tryAgain"
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
            
            HStack(spacing: 10) {
                ForEach(Difficulty.HardMode.colorOptions[3...4], id: \.self) {num in
                    Button(action: {
                        selectedAnswer = num;
                        if (selectedAnswer == questionArr[aNumber]) {
                            answer.append(true)
                            aNumber = aNumber + 1;
                            if (aNumber == questionArr.count) {
                                gameTurn = "win"
                            }
                        } else {
                            answer.append(false)
                            gameTurn = "tryAgain"
                        }
                    },
                           label: {
                        switch(num) {
                        case "yellow":
                            Text("        ")
                                .background(Color.yellow)
                                .padding(15)
                                .font(.system(size: 30.0))
                        default:
                            Text("        ")
                                .background(Color.green)
                                .padding(15)
                                .font(.system(size: 30.0))
                        }
                    })
                }
            }
        }
        
    }
    
    func displayQuestion() -> some View {
        return VStack{
            switch (qDisplay) {
            case "red":
                Rectangle()
                    .foregroundColor(Color.red)
                    .padding(15)
                    .frame(width: CGFloat(qSize), height: CGFloat(120))
                    .onAppear {
                        withAnimation {
                            qSize += 50;
                        }
                    }
                    .onDisappear {
                        qSize = 120;
                    }
            case "blue":
                Rectangle()
                    .foregroundColor(Color.blue)
                    .padding(15)
                    .frame(width: CGFloat(qSize), height: CGFloat(120))
                    .onAppear {
                        withAnimation {
                            qSize += 50;
                        }
                    }
                    .onDisappear {
                        qSize = 120;
                    }
            case "purple":
                Rectangle()
                    .foregroundColor(Color.purple)
                    .padding(15)
                    .frame(width: CGFloat(qSize), height: CGFloat(120))
                    .onAppear {
                        withAnimation {
                            qSize += 50;
                        }
                    }
                    .onDisappear {
                        qSize = 120;
                    }
            case "yellow":
                Rectangle()
                    .foregroundColor(Color.yellow)
                    .padding(15)
                    .frame(width: CGFloat(qSize), height: CGFloat(120))
                    .onAppear {
                        withAnimation {
                            qSize += 50;
                        }
                    }
                    .onDisappear {
                        qSize = 120;
                    }
            case "green":
                Rectangle()
                    .foregroundColor(Color.green)
                    .padding(15)
                    .frame(width: CGFloat(qSize), height: CGFloat(120))
                    .onAppear {
                        withAnimation {
                            qSize += 50;
                        }
                    }
                    .onDisappear {
                        qSize = 120;
                    }
            default:
                Rectangle()
                    .background(Color.white)
                    .padding(15)
                    .frame(width: CGFloat(qSize), height: CGFloat(120))
                    .onAppear {
                        withAnimation {
                            qSize += 50;
                        }
                    }
                    .onDisappear {
                        qSize = 120;
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
                if timeRemaining > 0 {
                    timeRemaining -= 1
                    qNumber = qNumber + 1
                    qDisplay = questionArr[qNumber];
                } else {
                    gameTurn = "user";
                }
            }
    }
    
    
    
    func displayTryAgain() -> some View {
        VStack {
            Button("Start Over", action: {
                resetGame();
            })
                .background(Color(red: 0.8, green: 0, blue: 0))
                .padding(10)
                .foregroundColor(Color.white)
                .font(.system(size: 20))
        }.background(Color(red: 0.8, green: 0, blue: 0))
            .frame(width: 150, height: 100)
    }
    
    func displayWin() -> some View {
        VStack {
            Button("Continue", action: {
                nextLevel();
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
        
        switch (gameTurn) {
        case "user":
            displayAnswerSelect();
            Spacer();
        case "tryAgain":
            displayTryAgain();
            Spacer();
        case "win":
            displayWin();
            Spacer();
        default:
            displayTimer();
            displayQuestion();
            Spacer();
            Spacer();
            
        }
        VStack {
            Text("Level \(numberOfQuestions - 1)")
                .padding(10)
                .background(Color.white)
                .foregroundColor(Color(red: 0, green: 0.5, blue: 1))
                .font(.system(size: 20.0))
                .border(Color(red: 0, green: 0.5, blue: 1))
                
        }
    }
}

