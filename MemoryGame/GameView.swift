//
//  GameView.swift
//  MemoryGame
//
//  Created by Mark Gire on 10/26/21.
//

import SwiftUI

struct GameView: View {
    
    @State var gameTurn = "computer";
    @State var isCorrect = Bool();
    @State var qNumber = 0;
    @State var aNumber = 0;
    @State var qDisplay = "black"
    @State var qSize = 100;
    @State var showQDisplay = false;

    let nums = ["blue", "red", "purple"];
    
    @State var questionArr = [String]()
    
    @State var answer = [Bool]();
    @State var selectedAnswer = String();
    let numberOfQuestions = 4;
    @State var timeRemaining = 4;
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    
    func setQuestion() {
        for index in 0...numberOfQuestions {
            var randomNumber = Int.random(in: 0..<3)
            if(index > 0) {
                while(questionArr[index - 1] == nums[randomNumber]) {
                    randomNumber = Int.random(in: 0..<3)
                }
            }
            questionArr.append(nums[randomNumber])
        }
        print(questionArr)
        qDisplay = questionArr[0]
    }
    
    func resetGame() {
        gameTurn = "computer";
        isCorrect = Bool();
        qNumber = 0;
        aNumber = 0;
        timeRemaining = 4
        answer = [Bool]();
        selectedAnswer = String();
        questionArr = [String]();
        qSize = 100;
    }
    
    func displayAnswerSelect() -> some View {
        HStack(spacing: 10) {
            ForEach(nums, id: \.self) {num in
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
                    print(answer);
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
            switch (qDisplay) {
            case "red":
                Rectangle()
                    .foregroundColor(Color.red)
                    .padding(15)
                    .frame(width: CGFloat(qSize), height: CGFloat(qSize))
                    .onAppear {
                        withAnimation {
                            qSize += 50;
                        }
                    }
                    .onDisappear {
                        qSize = 100;
                    }
            case "blue":
                Rectangle()
                    .foregroundColor(Color.blue)
                    .padding(15)
                    .frame(width: CGFloat(qSize), height: CGFloat(qSize))
                    .onAppear {
                        withAnimation {
                            qSize += 50;
                        }
                    }
                    .onDisappear {
                        qSize = 100;
                    }
            case "purple":
                Rectangle()
                    .foregroundColor(Color.purple)
                    .padding(15)
                    .frame(width: CGFloat(qSize), height: CGFloat(qSize))
                    .onAppear {
                        withAnimation {
                            qSize += 50;
                        }
                    }
                    .onDisappear {
                        qSize = 100;
                    }
            default:
                Rectangle()
                    .background(Color.black)
                    .padding(15)
                    .frame(width: CGFloat(qSize), height: CGFloat(qSize))
                    .onAppear {
                        withAnimation {
                            qSize += 50;
                        }
                    }
                    .onDisappear {
                        qSize = 100;
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
            Button("Try Again", action: {
                resetGame();
            })
        }
    }
    
    func displayWin() -> some View {
        VStack {
            Text("Completed")
        }
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
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
