//
//  LeagueTeams.swift
//  Sportawy
//
//  Created by Mac on 21/05/2023.
//

import Foundation

struct TeamsResponse: Codable {
    let success: Int
    let result: [TeamsInfo]
}

struct TeamsInfo: Codable {
    let eventKey: Int
    let eventDate: String
    let eventTime: String
    let eventHomeTeam: String
    let homeTeamKey: Int
    let eventAwayTeam: String
    let awayTeamKey: Int
    let homeTeamLogo: String
    let awayTeamLogo: String
    let eventFinalResult : String

    private enum CodingKeys: String, CodingKey {
        case eventKey = "event_key"
        case eventDate = "event_date"
        case eventTime = "event_time"
        case eventHomeTeam = "event_home_team"
        case homeTeamKey = "home_team_key"
        case eventAwayTeam = "event_away_team"
        case awayTeamKey = "away_team_key"
        case homeTeamLogo = "home_team_logo"
        case awayTeamLogo = "away_team_logo"
        case eventFinalResult = "event_final_result"
    }
}
