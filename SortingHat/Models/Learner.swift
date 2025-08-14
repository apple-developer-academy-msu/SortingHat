//
//  Learner.swift
//  SortingHat
//
//  Created by Nicholas Melekian on 8/1/23.
//

import Foundation

struct Learner: Identifiable, Hashable {
    let id: String
    var firstName: String
    var lastName: String
    var cohort: Cohort
    
    init(first: String, last: String, cohort: Cohort) {
        self.id = UUID().uuidString
        self.firstName = first
        self.lastName = last
        self.cohort = cohort
    }
}

extension Learner: Decodable {
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        let fields = try container.decode(LearnerResponse.RecordFields.self, forKey: .fields)
        self.firstName = fields.firstName
        self.lastName = fields.lastName
        
        if fields.cohort.contains("Morning") {
            self.cohort = .AM
        } else {
            self.cohort = .PM
        }
       
       
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case fields
    }
}

#if DEBUG
extension Learner {
    static var testLearner = Learner(first: "Tyriq", last: "Lawilliams", cohort: .AM)
    static var testLearners: [Learner]{
        var tempLearners = [Learner]()
        for i in 1...200 {
            tempLearners.append(Learner(first: "Tyriq\(i)", last: "LaWilliams", cohort: .AM))
        }
        return tempLearners
    }
    
}
#endif
