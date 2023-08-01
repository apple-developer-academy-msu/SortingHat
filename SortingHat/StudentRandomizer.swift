//
//  StudentRandomizer.swift
//  SortingHat
//
//  Created by Nicholas Melekian on 8/1/23.
//

import Foundation

class StudentRandomizer: ObservableObject {
    @Published var learners: [Learner] = []
    func sortLearners() -> [Team] {
        
        learners.shuffle()
        let teams =  learners.chunked(into: 5).map { Team(members: $0)}
        
        return teams
    }
}
