//
//  LearnerResponse.swift
//  SortingHat
//
//  Created by Kevin Buchholz on 8/2/23.
//

import Foundation

struct LearnerResponse: Decodable {
    let records: [Learner]
    let offset: String?
    
    struct RecordFields: Decodable {
        let firstName: String
        let lastName: String
        
        enum CodingKeys: String, CodingKey {
            case firstName = "FirstName"
            case lastName = "LastName"
        }
    }
}
