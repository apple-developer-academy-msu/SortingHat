//
//  StudentRandomizer.swift
//  SortingHat
//
//  Created by Nicholas Melekian on 8/1/23.
//

import Foundation

class StudentRandomizer: ObservableObject {
    @Published var learners: [Learner] = []
    @Published var sortedTeams: [Team]?
    @Published var error: Error?
    
    static let defaultTeamSize = 5
    
    init(learners: [Learner]) {
        self.learners = learners
    }
    
    func sortLearners() {
        sortedTeams = learners.shuffled().chunked(into: Self.defaultTeamSize).map { Team(members: $0) }
    }
    
    func loadLearners() async {
        let airTableService = AirtableService()
        
        do {
            learners = try await airTableService.fetchLearners()
        } catch {
            self.error = error
        }
    }
}
