//
//  AlamofireNetworkingDataSourceTest.swift
//  SportawyTests
//
//  Created by Mac on 30/05/2023.
//

import XCTest
@testable import Sportawy
final class AlamofireNetworkingDataSourceTest: XCTestCase {
    
    var alamofireDataSource: NetWorkingDataSource!
    
    override func setUpWithError() throws {
        alamofireDataSource = AlamofireNetworkingDataSource()
    }

    override func tearDownWithError() throws {
        alamofireDataSource = nil
    
    }
    
    func testLoadDataFromAPI_SuccessfulResponse() {
        
        let url = URLCreator().createLeaguesURL(for: SportType.football)
         alamofireDataSource.setURL(url)
         
         let expectation = XCTestExpectation(description: "API response received")
         alamofireDataSource.loadDataFromAPI { (response: LeagueItem?) in
             
             XCTAssertNotNil(response)
             expectation.fulfill()
         }

         wait(for: [expectation], timeout: 5.0)
     }

     func testLoadDataFromAPI_FailureResponse() {
         
         let url = "invalidUrl"
         
         alamofireDataSource = AlamofireNetworkingDataSource(url: url)
         
         alamofireDataSource.setURL(url)

         let expectation = XCTestExpectation(description: "API error response received")
         
         alamofireDataSource.loadDataFromAPI { (response: LeagueItem?) in
             XCTAssertNil(response)
             expectation.fulfill()
         }

         wait(for: [expectation], timeout: 5.0)
     }

    

}
