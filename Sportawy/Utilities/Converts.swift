//
//  Converts.swift
//  Sportawy
//
//  Created by Mac on 25/05/2023.
//

import Foundation

class Converts {
    
    
    func convertStringToSport(fromString : String) -> SportType?{
        
        switch fromString {
            
        case "football":
            return .football
        case "basketball":
            return .basketball
        case "cricket":
            return .cricket
        case "tennis":
            return .tennis
        default:
            return nil
            
        }
        
    }
    
}
