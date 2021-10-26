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
    
    let nums = ["blue", "red", "purple"];
    
    var question = ["blue", "purple", "red", "blue", "red"];
    
    @State var answer = [Bool]();
    @State var selectedAnswer = String();
    
    @State var timeRemaining = 4
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    func resetGame() {
        gameTurn = "computer";
        isCorrect = Bool();
        qNumber = 0;
        aNumber = 0;
        timeRemaining = nums.count;
        answer = [Bool]();
        selectedAnswer = String();
    }
    
    func displayAnswerSelect() -> some View {
        ForEach(nums, id: \.self) {num in
            HStack {
                Button(action: {
                    selectedAnswer = num;
                    if (selectedAnswer == question[aNumber]) {
                        answer.append(true)
                        aNumber = aNumber + 1;
                    } else {
                        answer.append(false)
                        gameTurn = "tryAgain"
                    }
                    print(answer);
                },
                       label: {
                    switch(num) {
                    case "red":
                        Text("  ")
                            .background(Color.red)
                    case "blue":
                        Text("  ")
                            .background(Color.blue)
                    default:
                        Text("  ")
                            .background(Color.purple)
                    }
                })
            }
        }
    }
    
    func displayQuestion() -> some View {
        return Text("")
            .onReceive(timer) { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                    qNumber = qNumber + 1
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
    
    var body: some View {
        
        switch (gameTurn) {
        case "user":
            displayAnswerSelect();
            Spacer();
        case "tryAgain":
            displayTryAgain();
            Spacer();
        default:
            displayQuestion();
            Spacer();
            VStack{
                Text(question[qNumber]);
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
