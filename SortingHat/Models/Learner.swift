//
//  Learner.swift
//  SortingHat
//
//  Created by Nicholas Melekian on 8/1/23.
//

import Foundation

struct Learner: Identifiable, Hashable {
    let id: String
    var first: String
    var last: String
    
    init(first: String, last: String) {
        self.id = UUID().uuidString
        self.first = first
        self.last = last
    }
}

extension Learner: Decodable {
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        let fields = try container.decode(LearnerResponse.RecordFields.self, forKey: .fields)
        self.first = fields.firstName
        self.last = fields.lastName
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case fields
    }
    
}

#if DEBUG
extension Learner {
    static var testLearner = Learner(first: "Tyriq", last: "Lawilliams")
    static var testLearners: [Learner]{
        var tempLearners = [Learner]()
        for i in 1...200 {
            tempLearners.append(Learner(first: "Tyriq\(i)", last: "LaWilliams"))
        }
        return tempLearners
    }
    
}
#endif
