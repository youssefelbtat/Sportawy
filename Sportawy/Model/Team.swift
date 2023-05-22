//
//  Team.swift
//  Sportawy
//
//  Created by Mac on 22/05/2023.
//


//https://apiv2.allsportsapi.com/football/?met=Teams&teamId=95&APIkey=31db8d4ada7770ceee6a59e49db726464f20538721615b14b40170d55749ba82

import Foundation

struct TeamResponse: Codable {
    let success: Int
    let result: [Team]
}

struct Team: Codable {
    let teamKey: Int
    let teamName: String
    let teamLogo: String
    let players: [Player]
    let coaches: [Coach]
    
    enum CodingKeys: String, CodingKey {
        case teamKey = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"
        case players
        case coaches
    }
}

