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
    
    let service: StudentFetchingService
    
    static let defaultTeamSize = 5
    
    init(learners: [Learner], service: StudentFetchingService = AirtableService()) {
        self.learners = learners
        self.service = service
    }
    
    func sortLearners() {
        sortedTeams = learners.shuffled().chunked(into: Self.defaultTeamSize).map { Team(members: $0) }
    }
    
    func loadLearners() async {        
        do {
            learners = try await service.fetchLearners()
        } catch {
            self.error = error
        }
    }
}
