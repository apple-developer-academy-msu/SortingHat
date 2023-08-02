//
//  StudentRandomizer.swift
//  SortingHat
//
//  Created by Nicholas Melekian on 8/1/23.
//

import Foundation

@MainActor
class StudentRandomizer: ObservableObject {
    @Published var learners: [Learner] = []
    @Published var sortedTeams: [Team]?
    @Published var error: Error?
    
    let service: StudentFetchingService
    
    static let defaultTeamSize = 5
    
    init(service: StudentFetchingService = AirtableService())  {
    
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

struct MockStudentFetchingService: StudentFetchingService {
    func fetchLearners() async throws -> [Learner] {
        Learner.testLearners
    }
}
