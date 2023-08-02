//
//  Network-Requests.swift
//  SortingHat
//
//  Created by Kevin Buchholz on 8/2/23.
//

import Foundation

class AirtableService {
    enum Endpoint: String {
        /*
         airtable limits us to 100 records at a time. need to use offset for subsequent requests
         offset is provided in a response (ex: "offset": "itrS8iG0rTWBYSMGg/recRFp0y4E1hOH9uO")
         
         https://api.airtable.com/v0/app8U1gITzFbzqxIH/junior_learners?filterByFormula=%7BCohort%7D+%3D+2024
         */
        
         
        case juniorLearners = "junior_learners?view=All" // jr learners from every cohort
    }
    
    
    
    private let baseUrl = "https://api.airtable.com/v0/app8U1gITzFbzqxIH/"
    // https://api.airtable.com/v0/app8U1gITzFbzqxIH/junior_learners?view=All
    
    func fetchLearners() async throws -> [Learner] {
        guard let url = URL(string: baseUrl + Endpoint.juniorLearners.rawValue) else { fatalError() }
        var urlRequest:URLRequest = URLRequest(url:url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("Bearer \(Secrets.apiKey)" , forHTTPHeaderField: "Authorization")
        let response: LearnerResponse = try await NetworkManager.shared.fetch(from: urlRequest)
        return response.learners
    }
}
