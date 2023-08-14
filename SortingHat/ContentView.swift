//
//  ContentView.swift
//  SortingHat
//
//  Created by Nicholas Melekian on 8/1/23.
//

import SwiftUI


// As a Mentor I would like a button that sorts a list of learners into teams of five so that I can easily randomize teams for challenges

// As a mentor I would like to fetch learners names from AirTable so that I can easily plug in an existing database of learners- for this story we're just concerned with grabbing 100 people and sorting them

// As a mentor I want to fetch all existing records from Airtable. If we're filtering by cohort there shouldn't be more than 100 records.

// How can we apply best practices and the new concepts we have been talking about? (Optionals, Generics, Protocolos, Extensions, etc.)
struct ContentView: View {
    @StateObject var randomizer: StudentRandomizer = StudentRandomizer()
    var body: some View {
        VStack{
            
            Button("Sort") {
                randomizer.sortLearners()
                
                print("\(randomizer.sortedTeams?.count)")
                print(randomizer.error?.localizedDescription)
                print(randomizer.sortedTeams)
        }
        }
        .task {
            await randomizer.loadLearners()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
