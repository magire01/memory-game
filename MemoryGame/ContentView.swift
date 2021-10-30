//
//  ContentView.swift
//  MemoryGame
//
//  Created by Mark Gire on 10/8/21.
//

import SwiftUI

struct ContentView: View {
    @State var isStarted = false;
    @State public var difficulty = "easy";
    @State var easySelected = true;
    @State var mediumSelected = false;
    @State var hardSelected = false;
    
    func setDifficulty() -> some View {
        return VStack {
            Button("Easy", action: {
                difficulty = "easy"
                easySelected = true;
                mediumSelected = false;
                hardSelected = false;
                
            })
                .padding(5)
                .foregroundColor(Color.white)
                .background(easySelected ? Color.green : Color.blue)
                .frame(width: 200, height: 50)
            Button("Medium", action: {
                difficulty = "medium"
                easySelected = false;
                mediumSelected = true;
                hardSelected = false;
            })
                .padding(5)
                .foregroundColor(Color.white)
                .background(mediumSelected ? Color.green : Color.blue)
                .frame(width: 200, height: 50)
            Button("Hard", action: {
                difficulty = "hard";
                easySelected = false;
                mediumSelected = false;
                hardSelected = true;
            })
                .padding(5)
                .foregroundColor(Color.white)
                .background(hardSelected ? Color.green : Color.blue)
                .frame(width: 200, height: 50)
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
        if(isStarted) {
            GameView(difficulty: $difficulty)
            
            VStack {
                Button("Quit", action:{
                    isStarted = false;
                })
                .padding(20)
                .foregroundColor(Color.red)
            }
            
        } else {
            VStack {
                Text("Select Difficulty");
                setDifficulty();
                Spacer();
                Button("Start Game", action:{
                    isStarted = true;
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
