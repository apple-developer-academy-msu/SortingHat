//
//  ContentView.swift
//  SortingHat
//
//  Created by Nicholas Melekian on 8/1/23.
//

import SwiftUI


// As a Mentor I would like a button that sorts a list of learners into teams of five so that I can easily randomize teams for challenges

// As a mentor I would like to fetch learners names from AirTable so that I can easily plug in an existing database of learners

// How can we apply best practices and the new concepts we have been talking about? (Optionals, Generics, Protocolos, Extensions, etc.)
struct ContentView: View {
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
