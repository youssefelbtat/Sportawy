//
//  LeagueEvent.swift
//  Sportawy
//
//  Created by Mac on 21/05/2023.
//

import Foundation



struct EventResponse: Codable {
    let success: Int
    let result: [EventInfo]
}

struct EventInfo: Codable {
    let eventKey: Int
    let eventDate: String
    let eventTime: String
    let firstTeamName: String
    let homeTeamKey: Int
    let secondTeamName: String
    let awayTeamKey: Int
    let firstTeamLogo: String
    let secondTeamLogo: String
    let eventFinalResult : String

    private enum CodingKeys: String, CodingKey {
        case eventKey = "event_key"
        case eventDate = "event_date"
        case eventTime = "event_time"
        case firstTeamName = "event_home_team"
        case homeTeamKey = "home_team_key"
        case secondTeamName = "event_away_team"
        case awayTeamKey = "away_team_key"
        case firstTeamLogo = "home_team_logo"
        case secondTeamLogo = "away_team_logo"
        case eventFinalResult = "event_final_result"
    }
}
