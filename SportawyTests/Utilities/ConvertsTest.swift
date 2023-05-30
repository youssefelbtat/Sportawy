//
//  ConvertsTest.swift
//  SportawyTests
//
//  Created by Mac on 28/05/2023.
//

import XCTest
@testable import Sportawy
final class ConvertsTest: XCTestCase {
    
    var converter:Convertor!
    override func setUpWithError() throws {
        converter = Convertor()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        converter = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testConvertStringToSportWithValidString() {
            let converter = Convertor()
            let sport = converter.convertStringToSport(fromString: "football")

            XCTAssertEqual(sport, SportType.football)
        }

    func testConvertStringToSportWithInvalidString() {
            let converter = Convertor()
            let sport = converter.convertStringToSport(fromString: "Swimming")

            XCTAssertNil(sport)
        }


}
