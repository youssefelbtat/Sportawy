//
//  ViewControllerMocking.swift
//  SportawyTests
//
//  Created by Mac on 29/05/2023.
//

import Foundation
import UIKit

class MockViewController: UIViewController {
    var alert: UIAlertController?

    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        alert = viewControllerToPresent as? UIAlertController
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
}
