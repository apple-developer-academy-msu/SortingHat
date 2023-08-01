//
//  Learner.swift
//  SortingHat
//
//  Created by Nicholas Melekian on 8/1/23.
//

import Foundation

struct Learner: Identifiable {
    let id = UUID()
    var first: String
    var last: String
}

#if DEBUG
extension Learner {
    static var testLearner = Learner(first: "Tyriq", last: "Lawilliams")
    static var testLearners: [Learner] = Array(repeating: testLearner, count: 200)
}
#endif
