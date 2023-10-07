//
//  ParisSportifsTests.swift
//  ParisSportifsTests
//
//  Created by Moez bachagha on 5/10/2023.
//

import XCTest
@testable import ParisSportifs

final class ParisSportifsTests: XCTestCase {

    let mockAPI = MockLeagueAPI()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {

    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testGettingLeagueWithMockEmptyResult() {
        let expectation = expectation(description: "testing empty state with mock api")

        mockAPI.loadState = .empty

        let viewModel = LeaguesViewModel(apiService: mockAPI)
        viewModel.getLeagues { Leagues, error in

            XCTAssertTrue(Leagues?.isEmpty == true, "Expected Leagues to be empty, but received some values")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0) { error in
            if let error = error {
                XCTFail("Expectation failed \(error)")
            }
        }
    }

    func testGettingLeaguesWithErrorResult() {
        let expectation = expectation(description: "testing error state with mock api")

        mockAPI.loadState = .error

        let viewModel = LeaguesViewModel(apiService: mockAPI)
        viewModel.getLeagues { Leagues, error in
            XCTAssertTrue(Leagues == nil, "Expected to get no movies and error, but received Leagues")
            XCTAssertNotNil(error, "Expected to get an error, but received no error")

            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0) { error in
            if let error = error {
                XCTFail("Expectation failed \(error)")
            }
        }
    }

    func testGettingLeaguesWithSuccess() {
        let expectation = expectation(description: "testing success state with mock api")

        mockAPI.loadState = .loaded

        let viewModel = LeaguesViewModel(apiService: mockAPI)
        viewModel.getLeagues { Leagues, error in
            XCTAssert(Leagues?.isEmpty == false, "Expected to get Leagues")
            XCTAssertNil(error, "Expected error to be nil")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0) { error in
            if let error = error {
                XCTFail("Expectation failed \(error)")
            }
        }
    }

    func testGettingTeamsWithErrorResult() {
        let expectation = expectation(description: "testing error state with mock api")

        mockAPI.loadState = .error

        let viewModel = LeaguesViewModel(apiService: mockAPI)
        viewModel.getTeamsByLeague(LeagueTeam : "Frensh Ligue 1", completion:  { [weak self] Teams, error in

            XCTAssertTrue(Teams == nil, "Expected to get no movies and error, but received Leagues")
            XCTAssertNotNil(error, "Expected to get an error, but received no error")

            expectation.fulfill()
        })

        waitForExpectations(timeout: 1.0) { error in
            if let error = error {
                XCTFail("Expectation failed \(error)")
            }
        }
    }

    func testGettingTeamsWithSuccess() {
        let expectation = expectation(description: "testing success state with mock api")

        mockAPI.loadState = .loaded

        let viewModel = LeaguesViewModel(apiService: mockAPI)
        viewModel.getTeamsByLeague(LeagueTeam : "Frensh Ligue 1", completion:  { [weak self] Teams, error in
            XCTAssert(Teams?.isEmpty == false, "Expected to get Leagues")
            XCTAssertNil(error, "Expected error to be nil")
            expectation.fulfill()
        })

        waitForExpectations(timeout: 1.0) { error in
            if let error = error {
                XCTFail("Expectation failed \(error)")
            }
        }
    }

}
