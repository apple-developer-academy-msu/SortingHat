//
//  StudentRandomizerTests.swift
//  SortingHatTests
//
//  Created by Nicholas Melekian on 8/1/23.
//

import XCTest
@testable import SortingHat

final class StudentRandomizerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testZeroLearnersCreatesZeroSortedTeams() throws {
        // Arrange
        let randomizer = StudentRandomizer(learners: [])
        
        // Act
        randomizer.sortLearners()
        
        // Assert
        XCTAssertEqual(randomizer.sortedTeams?.count, 0)
    }

    func testDivisbilityByFiveCreateTeamWithLessThanFive() throws {
        // Arrange
        let randomizer = StudentRandomizer(learners: Array(repeating: Learner.testLearner, count: 198))
        
        // Act
        randomizer.sortLearners()
        // Assert
        XCTAssertEqual(randomizer.sortedTeams?.count, 40)
    }
    
    func testSorting200LearnersCreateTeamsOfFive() {
        // Arrange
        let randomizer = StudentRandomizer(learners: Array(repeating: Learner.testLearner, count: 200))
        
        // Act
        randomizer.sortLearners()
        
        // Assert
        
        for team in randomizer.sortedTeams! {
            
            XCTAssertEqual(team.members.count, 5)
        }
        
        
    }
    
    func testSortedTeamsHasValueAfterSort() throws {
        // Arrange
        let randomizer = StudentRandomizer(learners: Array(repeating: Learner.testLearner, count: 200))
        
        // Act
        randomizer.sortLearners()
        // Assert
        XCTAssertNotNil(randomizer.sortedTeams )
    }
    
    
    
    func testSortedTeamIsNilBeforeSort() throws {
        
        // Arrange/Act
        let randomizer = StudentRandomizer(learners: Array(repeating: Learner.testLearner, count: 200))
        
    
        
        // Assert
        XCTAssertNil(randomizer.sortedTeams )
        
        
        
    }
    
    func testSortedTeamHasNoDuplicateLearners() throws {
        
        
        // Arrange
        let randomizer = StudentRandomizer(learners: Learner.testLearners)
        
        // Act
        randomizer.sortLearners()
        
        // Assert
        guard let sortedTeams = randomizer.sortedTeams else {
            XCTFail("no teams created")
            return
        }
        
        let allLearners: [Learner] = sortedTeams.flatMap { team in
            print(team.members)
            return team.members
        }
        let uniqueLearners = Set(allLearners)
        
        XCTAssertEqual(uniqueLearners.count, allLearners.count)
    }
    

}
