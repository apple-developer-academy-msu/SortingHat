//
//  StudentFetchingService.swift
//  SortingHat
//
//  Created by Kevin Buchholz on 8/2/23.
//

import Foundation

protocol StudentFetchingService {
    var offset: String? {get}
    func fetchLearners() async throws -> [Learner]
}
