//
//  ContentView.swift
//  MemoryGame
//
//  Created by Mark Gire on 10/8/21.
//

import SwiftUI

struct ContentView: View {
    @State var isStarted = false;
    
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
            GameView();
            
            VStack {
                Button("Quit", action:{
                    isStarted = false;
                })
                .padding(20)
                .foregroundColor(Color.red)
            }
            
        } else {
            VStack {
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
