//
//  LeaguesModel.swift
//  Sportawy
//
//  Created by Mac on 19/05/2023.
//

import Foundation

class LeagueItem : Decodable{
    var country_key : Int?
    var country_name : String?
    var league_key : Int?
    var league_logo : String?
    var country_logo : String?
    var league_name : String?
   
    
    enum CodingKeys: String, CodingKey{
        case country_key = "country_key"
        case country_name = "country_name"
        case league_key = "league_key"
        case league_logo = "league_logo"
        case country_logo = "country_logo"
        case league_name = "league_name"
    }
    
    init(country_key: Int? = nil, country_name: String? = nil, league_key: Int? = nil, league_logo: String? = nil, country_logo: String? = nil, league_name: String? = nil) {
        self.country_key = country_key
        self.country_name = country_name
        self.league_key = league_key
        self.league_logo = league_logo
        self.country_logo = country_logo
        self.league_name = league_name
    }
}

class LeagueResult : Decodable {
    var result : [LeagueItem]
    var success : Int?
}
