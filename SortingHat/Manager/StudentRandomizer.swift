//
//  StudentRandomizer.swift
//  SortingHat
//
//  Created by Nicholas Melekian on 8/1/23.
//

import Foundation
import Observation

enum LoadingState {
    case loading
    case notLoading
}

@MainActor
@Observable class StudentRandomizer {
    var learners: [Learner] = []
    var sortedTeams: [Team] = []
    var error: Error?
    var loadingState: LoadingState = .notLoading
    
    let service: StudentFetchingService
    init(service: StudentFetchingService = AirtableService())  {
    
        self.service = service
    }
    
    func sortLearners(intoTeamsOf teamSize: Int, and cohort: Cohort) async {
        loadingState = .loading
        await filterLearnersByCohort(cohort)
        sortedTeams = learners.shuffled().chunked(into: teamSize ).map { Team(learners: $0) }
        loadingState = .notLoading
    }
    
    func loadLearners() async -> [Learner] {
        print("\(learners.count)")
        var learners: [Learner] = []
        
        do {
           learners = try await service.fetchLearners()
            
            while service.offset != nil {
           learners += try await service.fetchLearners()
                print("\(learners.count)")
            }
        
        } catch {
            self.error = error
        }
       
        print("\(learners.count)")
        return learners
    }
    func filterLearnersByCohort(_ cohort: Cohort)  async{
       // learners = learners.filter { $0.cohort == cohort }
        learners = await loadLearners().filter { $0.cohort == cohort }
        print("we have \(learners.count) with the filter for \(cohort)")
    }
}

//struct MockStudentFetchingService: StudentFetchingService {
//    var offset: String?
//    
//    func fetchLearners() async throws -> [Learner] {
//        Learner.testLearners
//    }
//}
