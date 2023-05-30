//
//  MockNetworkManager.swift
//  SportawyTests
//
//  Created by Mac on 30/05/2023.
//

import XCTest
@testable import Sportawy
final class MockNetworkManager: XCTestCase {
    
    var fakeNetwork : NetWorkingDataSource!
    
    override func setUpWithError() throws {
        fakeNetwork = FakeNetwork(shouldReturnError: true)
    }

    override func tearDownWithError() throws {
        fakeNetwork = nil
    }
    
    func testLoadDataFromAPI_usingFakeNetwork_FailureResponse(){
        
        fakeNetwork.loadDataFromAPI { (result: LeagueResult?) in
            
            if result != nil{
                XCTAssertEqual(result?.result?.count, 2)
            }
            else{
                XCTAssertNil(result,"Result is nil")
            }
        }
        
    }
    
    func testLoadDataFromAPI_usingFakeNetwork_SuccessResponse(){
        
        fakeNetwork = FakeNetwork(shouldReturnError: false)

        fakeNetwork.loadDataFromAPI { (result: LeagueResult?) in
           
            if result != nil{
                
                XCTAssertEqual(result?.result?.count, 2)
                XCTAssertEqual(result?.result?.first?.league_key, 4 )
                XCTAssert( result?.result?.first?.country_key == 1)
                XCTAssertNotNil(result?.result?.first?.league_name)
                XCTAssertNil(result?.result?.first?.country_logo)
                
                XCTAssertEqual(result?.result?[1].league_key, 1 )
                XCTAssert(result?.result?[1].country_key == 1)
                XCTAssertNotNil(result?.result?[1].league_name)
                XCTAssertFalse(result?.result?[1].league_key == 2)
                XCTAssertNil(result?.result?[1].country_logo)
            }
            else{
                XCTFail("Result is nil")
            }
        }
        
    }

   

}
