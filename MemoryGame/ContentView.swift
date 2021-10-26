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
        Spacer();
        if(isStarted) {
            GameView();
            
            VStack {
                Button("Quit", action:{
                    isStarted = false;
                })
                .padding(20)
            }
            
        } else {
            VStack {
                Button("Start Game", action:{
                    isStarted = true;
                    print(isStarted);
                })
                .padding(20)
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
