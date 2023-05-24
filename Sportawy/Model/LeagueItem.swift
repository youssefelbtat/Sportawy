//
//  Models.swift
//  Sportawy
//
//  Created by Mac on 20/05/2023.
//

import Foundation

struct LeagueItem : Decodable{
    var country_key : Int?
    var country_name : String?
    var league_key : Int?
    var league_logo : String?
    var country_logo : String?
    var league_name : String?
    var league_type : String?
   
    
    private enum CodingKeys: String, CodingKey{
        case country_key = "country_key"
        case country_name = "country_name"
        case league_key = "league_key"
        case league_logo = "league_logo"
        case country_logo = "country_logo"
        case league_name = "league_name"
        case league_type
    }
    
}

struct LeagueResult : Decodable {
    var result : [LeagueItem]?
    var success : Int?
}
