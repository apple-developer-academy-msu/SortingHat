//
//  StudentRandomizer.swift
//  SortingHat
//
//  Created by Nicholas Melekian on 8/1/23.
//

import Foundation
import Observation

@MainActor
@Observable class StudentRandomizer {
    var learners: [Learner] = []
    var sortedTeams: [Team] = []
    var error: Error?
    
    let service: StudentFetchingService
    
    static let defaultTeamSize = 5
    
    init(service: StudentFetchingService = AirtableService())  {
    
        self.service = service
    }
    
    func sortLearners(intoTeamsOf teamSize: Int) {
        sortedTeams = learners.shuffled().chunked(into: teamSize ).map { Team(learners: $0) }
    }
    
    func loadLearners() async {        
        do {
            learners = try await service.fetchLearners()
     
        } catch {
            self.error = error
        }
    }
}

struct MockStudentFetchingService: StudentFetchingService {
    func fetchLearners() async throws -> [Learner] {
        Learner.testLearners
    }
}
