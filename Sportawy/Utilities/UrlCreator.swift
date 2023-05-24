//
//  UrlCreator.swift
//  Sportawy
//
//  Created by Mac on 23/05/2023.
//

import Foundation

class URLCreator {
    
    private let baseURL = "https://apiv2.allsportsapi.com"
    private let apiKey = "31db8d4ada7770ceee6a59e49db726464f20538721615b14b40170d55749ba82"
    
    func createLeaguesURL(for sportType: SportType) -> String {
        
        return "\(baseURL)/\(sportType.rawValue.lowercased())/?met=Leagues&APIkey=\(apiKey)"
       
    }
    
    func createUpcomingEventsURL(for sportType: SportType, leagueId: String) -> String {
        
        let currentDate = Date()
        let oneYearFromNow = Calendar.current.date(byAdding: .year, value: 1, to: currentDate)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
       
        
        return "\(baseURL)/\(sportType)?met=Fixtures&leagueId=\(leagueId)&from=\(dateFormatter.string(from: currentDate))&to=\(dateFormatter.string(from: oneYearFromNow))&APIkey=\(apiKey)"
    }
    
    
    
    func createLatestResultsURL(for sportType: SportType, leagueId: String) -> String {
        
        let currentDate = Date()
        let oneYearAgo = Calendar.current.date(byAdding: .year, value: -1, to: currentDate)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        
        return "\(baseURL)/\(sportType)?met=Fixtures&leagueId=\(leagueId)&from=\(dateFormatter.string(from: oneYearAgo))&to=\(dateFormatter.string(from: currentDate))&APIkey=\(apiKey)"
    }
    
    //https://apiv2.allsportsapi.com/football/?&met=Teams&teamId=96&APIkey=31db8d4ada7770ceee6a59e49db726464f20538721615b14b40170d55749ba82
    func createOneTeamURL(for sportType: SportType , teamId: String ) -> String{
         
        return "\(baseURL)/\(sportType)/?&met=Teams&teamId=\(teamId)&APIkey=\(apiKey)"
        
    }
    
    func createTeamsURL(for sportType: SportType, leagueId: String) -> String {
       
        return "\(baseURL)/\(sportType)/?&met=Teams&leagueId=\(leagueId)&APIkey=\(apiKey)"
    }
}
