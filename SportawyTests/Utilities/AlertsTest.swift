//
//  AlertsTest.swift
//  SportawyTests
//
//  Created by Mac on 28/05/2023.
//

import XCTest
@testable import Sportawy
final class AlertsTest: XCTestCase {
    
    var viewController: MockViewController!
    override func setUpWithError() throws {
        viewController = MockViewController()
    }

    override func tearDownWithError() throws {
        viewController = nil
    }

    func testShowAlertNoInternet() {
        
           let alertType = AlertType.noInternet

           alertType.showAlert(in: viewController)

           XCTAssertEqual(viewController.alert?.title, ConstantsStrings.NO_INTERNET_ALERT_TITLE)
           XCTAssertNotNil(viewController.alert?.message)
           XCTAssertTrue(viewController.alert?.actions.count == 1)
           
       }
    
    func testShowAlertCommingSoon() {
        let alertType = AlertType.comingSoon

        alertType.showAlert(in: viewController)

        XCTAssertEqual(viewController.alert?.title, ConstantsStrings.COMING_SOON_ALERT_TITLE)
        XCTAssertNotNil(viewController.alert?.message)
        XCTAssertTrue(viewController.alert?.actions.count == 1)
    }
    
    func testShowAlertConfirmRemove() {
       
        let alertType = AlertType.confirmRemove(deleteHandler: {
           
        })

        alertType.showAlert(in: viewController)

        XCTAssertEqual(viewController.alert?.title, ConstantsStrings.REMOVE_ALERT_TITLE)
        XCTAssertNotNil(viewController.alert?.message)
        XCTAssertTrue(viewController.alert?.actions.count == 2)

    
    }



}


