//
//  Learner.swift
//  SortingHat
//
//  Created by Nicholas Melekian on 8/1/23.
//

import Foundation

struct Learner: Identifiable, Hashable {
    let id = UUID()
    var first: String
    var last: String
    
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
