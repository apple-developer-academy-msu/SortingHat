//
//  Model.swift
//  SortingHat
//
//  Created by Nicholas Melekian on 8/1/23.
//

import Foundation

struct Learner: Identifiable {
    let id = UUID()
    var first: String
    var last: String
}

struct Team {
    var members: [Learner]
    

}



extension Array {
    
    func chunked(into size:Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            
            Array(self[$0 ..< Swift.min($0 + size, count)])
            
        }
    }
}




class StudentRandomizer: ObservableObject {
    @Published var learners: [Learner] = []
    
    
    func sortLearners() -> [Team] {
        
        learners.shuffle()
        let teams =  learners.chunked(into: 5).map { Team(members: $0)}
        
        return teams
    }
}
