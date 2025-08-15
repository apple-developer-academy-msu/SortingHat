//
//  Network-Requests.swift
//  SortingHat
//
//  Created by Kevin Buchholz on 8/2/23.
//

import Foundation

class AirtableService: StudentFetchingService {
    var offset: String?
    
    enum Endpoint: String {
        /*
         airtable limits us to 100 records at a time. need to use offset for subsequent requests
         offset is provided in a response (ex: "offset": "itrS8iG0rTWBYSMGg/recRFp0y4E1hOH9uO")
         
         https://api.airtable.com/v0/app8U1gITzFbzqxIH/junior_learners?filterByFormula=%7BCohort%7D+%3D+2024
         */
        
         
        case juniorLearners = "junior_learners?view=All" // jr learners from every cohort
    }
    
   
       private let pageSize = 100
       private let maxRecords = 250
   
   

  //  private var baseUrl = "https://api.airtable.com/v0/appwJwPc7tsDFU3lw/JuniorLearners?tbleYuru2pkCNoLe6"
    // https://api.airtable.com/v0/app8U1gITzFbzqxIH/junior_learners?view=All
    
    func fetchLearners() async throws -> [Learner] {
        
        var baseUrl = "https://api.airtable.com/v0/appwJwPc7tsDFU3lw/JuniorLearners?tbleYuru2pkCNoLe6?pageSize=\(pageSize)&maxRecords=\(maxRecords)"
        if let offset = offset {
                     baseUrl += "&offset=\(offset)"
            print("offset is: \(offset)")
                 }
        
        guard let url = URL(string: baseUrl) else { fatalError() }
        var urlRequest:URLRequest = URLRequest(url:url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("Bearer patXxFUTCWbkIMRjn.9e8de123b093576de093323c015950fb44fa93e907cfb865469fb9cf265851fa" , forHTTPHeaderField: "Authorization")
        let response: LearnerResponse = try await NetworkManager.shared.fetch(from: urlRequest)
        
        self.offset = response.offset
        if response.offset == nil {
            offset = nil
            baseUrl = "https://api.airtable.com/v0/appwJwPc7tsDFU3lw/JuniorLearners?tbleYuru2pkCNoLe6?pageSize=\(pageSize)&maxRecords=\(maxRecords)"
        }
        return response.records
    }
}
