//
//  Alerts.swift
//  Sportawy
//
//  Created by Mac on 23/05/2023.
//

import Foundation
import UIKit



import UIKit

enum AlertType {
    
    case noInternet
    case comingSoon
    case confirmRemove(deleteHandler: () -> Void)
    
    
    var title: String {
        
        switch self {
            case .noInternet:
            return ConstantsStrings.NO_INTERNET_ALERT_TITLE
            case .confirmRemove:
            return ConstantsStrings.REMOVE_ALERT_TITLE
            case .comingSoon:
            return ConstantsStrings.COMING_SOON_ALERT_TITLE
        }
    }
    
    var message: String {
        
        switch self {

        case .noInternet:
            return ConstantsStrings.NO_INTERNET_ALERT_MESSAGE
        case .confirmRemove:
            return ConstantsStrings.REMOVE_ITEM_ALERT_MESSAGE
        case .comingSoon:
            return ConstantsStrings.COMING_SOON_ALERT_MESSAGE
        }
    }
    
    func showAlert(in viewController: UIViewController) {
            let alertController = UIAlertController(title: self.title, message: self.message, preferredStyle: .alert)
            
            switch self {
            case let .confirmRemove(deleteHandler):
                let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
                    deleteHandler()
                }
                alertController.addAction(deleteAction)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                
            default:
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
            }
            
            viewController.present(alertController, animated: true, completion: nil)
        }
}

    
    

