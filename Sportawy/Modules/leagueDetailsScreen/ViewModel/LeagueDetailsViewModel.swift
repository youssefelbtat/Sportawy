//
//  LeagueDetailsViewModel.swift
//  Sportawy
//
//  Created by Mac on 22/05/2023.
//

import Foundation

class LeagueDetailsViewModel{
    
    
    var bindDataToView : (()->()) = {}
    var netWorkingDataSource : NetWorkingDataSource
    
    
    var allLeagueEvents : [EventInfo] = [] {
        didSet{
            DispatchQueue.main.async {
                self.bindDataToView()
            }
        }
    }
    
    var allLeagueLastResults : [EventInfo] = [] {
        
        didSet{
            DispatchQueue.main.async {
                self.bindDataToView()
            }
        }
    }
    
    var allLeagueTeams : [TeamsInfo] = [] {
        
        didSet{
            DispatchQueue.main.async {
                self.bindDataToView()
            }
        }
        
    }
   
    
    init(netWorkingDataSource: NetWorkingDataSource ) {
        self.netWorkingDataSource = netWorkingDataSource
    }
    
    func loadAllLeagueEvents(withUrl url: String){
        netWorkingDataSource.setURL(url)
        netWorkingDataSource.loadDataFromAPI { [weak self] (result : EventResponse?) in
            if let items = result?.result {
                
                self!.allLeagueEvents = items
                
            }
        }
    }
    
    func loadAllLeagueLastResults(withUrl url: String){
        netWorkingDataSource.setURL(url)
        netWorkingDataSource.loadDataFromAPI { [weak self] (result : EventResponse?) in
            if let items = result?.result {
                
                self!.allLeagueLastResults = items
                
            }
        }
    }
    
    func loadAllLeagueTeams(withUrl url: String){
        netWorkingDataSource.setURL(url)
        netWorkingDataSource.loadDataFromAPI { [weak self] (result : TeamsResponse?) in
            if let items = result?.result {
                
                self!.allLeagueTeams = items
                
            }
        }
    }
    
    
    
    
    
}
