//
//  ContentView.swift
//  MemoryGame
//
//  Created by Mark Gire on 10/8/21.
//

import SwiftUI

struct ContentView: View {
    
    //DifficultyViewModel
    @ObservedObject var DifficultyModel = DifficultyViewModel()
    
    @State var isStarted = "none";
    @State var difficulty = "easy";
    
    func setDifficulty() -> some View {
        return VStack {
            Button("Easy", action: {
                difficulty = DifficultyModel.EasyMode.difficulty
            })
                .padding(5)
                .foregroundColor(Color.white)
                .background((difficulty == DifficultyModel.EasyMode.difficulty) ? Color.green : Color.blue)
                .frame(width: 200, height: 50)
            Button("Medium", action: {
                difficulty = DifficultyModel.MediumMode.difficulty
            })
                .padding(5)
                .foregroundColor(Color.white)
                .background((difficulty == DifficultyModel.MediumMode.difficulty) ? Color.green : Color.blue)
                .frame(width: 200, height: 50)
            Button("Hard", action: {
                difficulty = DifficultyModel.HardMode.difficulty
            })
                .padding(5)
                .foregroundColor(Color.white)
                .background((difficulty == DifficultyModel.HardMode.difficulty) ? Color.green : Color.blue)
                .frame(width: 200, height: 50)
        }
    }
    
    func QuitGame() -> some View {
        return VStack {
            Button("Quit", action:{
                isStarted = "none";
            })
            .padding(20)
            .foregroundColor(Color.red)
        }
    }
    
    var body: some View {
        Text("Memory Game")
        .padding(50)
        .border(Color.white)
        .padding(10)
        .background(Color(red: 0, green: 0.5, blue: 1))
        .foregroundColor(Color.white)
        .font(.system(size: 30.0))
        Spacer();
        
        switch(isStarted) {
        case DifficultyModel.EasyMode.difficulty:
            EasyView()
            QuitGame()
        case DifficultyModel.MediumMode.difficulty:
            MediumView();
            QuitGame()
        case DifficultyModel.HardMode.difficulty:
            HardView();
            QuitGame()
        default:
            VStack {
                Text("Select Difficulty")
                    .padding(5)
                    .foregroundColor(Color(red: 0, green: 0, blue: 0.5))
                setDifficulty();
                Spacer();
                Button("Start Game", action:{
                    isStarted = difficulty;
                })
                .padding(20)
                .background(Color(red: 0, green: 0, blue: 0.5))
                .foregroundColor(Color.white)
                .clipShape(Capsule())
                Spacer();
            }
            Spacer();
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
