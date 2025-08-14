//
//  Team.swift
//  SortingHat
//
//  Created by Nicholas Melekian on 8/1/23.
//

import Foundation

struct Team: Identifiable {
    var id = UUID()
    var learners: [Learner]
}
