//
//  SportawyTests.swift
//  SportawyTests
//
//  Created by Mac on 24/05/2023.
//

import XCTest
@testable import Sportawy
//import Alamofire
final class SportawyTests: XCTestCase {
    
    //var urlCreator : URLCreator!
    override func setUpWithError() throws {
        //  urlCreator = URLCreator()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
      //  urlCreator = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCreateLeaguesURL() {
      
        
        let expectedURL = "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=31db8d4ada7770ceee6a59e49db726464f20538721615b14b40170d55749ba82"
        
        let actualURL = urlCreator.createLeaguesURL(for: SportType.football)
        
        XCTAssertEqual(actualURL, expectedURL)
    }
    
    func testCreateUpcomingEventsURL() {

        let expectedURL = "https://apiv2.allsportsapi.com/football?met=Fixtures&leagueId=123&from=2023-05-25&to=2024-05-25&APIkey=31db8d4ada7770ceee6a59e49db726464f20538721615b14b40170d55749ba82"
        
        let id = "123"
        
        let actualURL = urlCreator.createUpcomingEventsURL(for: SportType.football, leagueId: id)
        
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
        
        let actualURL = urlCreator.createTeamsURL(for: sportType, leagueId: id)
        
        XCTAssertEqual(actualURL, expectedURL)
    }
    

}

