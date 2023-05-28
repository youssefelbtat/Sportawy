//
//  SportawyTests.swift
//  SportawyTests
//
//  Created by Mac on 28/05/2023.
//

import XCTest
@testable import Sportawy
final class SportawyTests: XCTestCase {

    var urlCreator : URLCreator!
        override func setUpWithError() throws {
              urlCreator = URLCreator()
        }

        override func tearDownWithError() throws {
            urlCreator = nil
        }
        
        func testCreateLeaguesURL() {
          
            
            let expectedURL = "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=31db8d4ada7770ceee6a59e49db726464f20538721615b14b40170d55749ba82"
            
            let actualURL = urlCreator.createLeaguesURL(for: SportType.football)
            
            XCTAssertEqual(actualURL, expectedURL)
        }
        
        func testCreateUpcomingEventsURL() {
            
            let currentDate = Date()
            let oneYearFromNow = Calendar.current.date(byAdding: .year, value: 1, to: currentDate)!
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let id = "123"
            
            let expectedURL = "https://apiv2.allsportsapi.com/football?met=Fixtures&leagueId=\(id)&from=\(dateFormatter.string(from: currentDate))&to=\(dateFormatter.string(from: oneYearFromNow))&APIkey=31db8d4ada7770ceee6a59e49db726464f20538721615b14b40170d55749ba82"
            
           
            
            let actualURL = urlCreator.createUpcomingEventsURL(for: SportType.football, leagueId: id)
            
            print(actualURL)
            
            XCTAssertTrue(actualURL == expectedURL)
        }
        
        func testCreateLatestResultsURL() {
            let id = "123"
            let actualURL = urlCreator.createUpcomingEventsURL(for: SportType.football, leagueId: id)
            
            XCTAssertNotNil(actualURL)
        }
        
        func testCreateOneTeamURL() {
           
       
            
            let expectedURL = "https://apiv2.allsportsapi.com/football/?&met=Teams&teamId=456&APIkey=31db8d4ada7770ceee6a59e49db726464f20538721615b14b40170d55749ba82"
            let id = "456"
            let actualURL = urlCreator.createOneTeamURL(for: SportType.basketball, teamId: id)
            
            XCTAssertFalse(expectedURL == actualURL)
        }
        
        func testCreateTeamsURL() {
           
           
            
            let expectedURL = "https://apiv2.allsportsapi.com/football/?&met=Teams&leagueId=123&APIkey=31db8d4ada7770ceee6a59e49db726464f20538721615b14b40170d55749ba82"
            let id = "123"
            
            let actualURL = urlCreator.createTeamsURL(for: SportType.football, leagueId: id)
            
            XCTAssertEqual(actualURL, expectedURL)
        }
}

