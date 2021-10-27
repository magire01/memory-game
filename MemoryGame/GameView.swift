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
    @State var qDisplay = "blue";
    
    let nums = ["blue", "red", "purple"];
    
    var question = ["blue", "purple", "red", "blue", "red"];
    
    @State var answer = [Bool]();
    @State var selectedAnswer = String();
    
    @State var timeRemaining = 4;
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    func resetGame() {
        gameTurn = "computer";
        isCorrect = Bool();
        qNumber = 0;
        aNumber = 0;
        timeRemaining = 4
        answer = [Bool]();
        selectedAnswer = String();
    }
    
    func displayAnswerSelect() -> some View {
        HStack(spacing: 10) {
            ForEach(nums, id: \.self) {num in
            
                Button(action: {
                    selectedAnswer = num;
                    if (selectedAnswer == question[aNumber]) {
                        answer.append(true)
                        aNumber = aNumber + 1;
                        if (aNumber == question.count) {
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
    
    func displayTimer() -> some View {
        return Text("")
            .onReceive(timer) { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                    qNumber = qNumber + 1
                    qDisplay = question[qNumber];
                    
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
            Spacer();
            VStack{
                switch (qDisplay) {
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
                case "purple":
                    Text("        ")
                        .background(Color.purple)
                        .padding(15)
                        .font(.system(size: 30.0))
                default:
                    Text("        ")
                        .background(Color.white)
                        .padding(15)
                        .font(.system(size: 30.0))
                }
            }
            Spacer();
            
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
