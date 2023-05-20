//
//  LeaguesListViewModel.swift
//  Sportawy
//
//  Created by Mac on 19/05/2023.
//


import Foundation

class LeaguesListViewModel {
    
    var bindResultToView : (()->()) = {}
    
    var allSelctedSportLeagues : [LeagueItem] = [] {
        didSet{
            DispatchQueue.main.async {
                self.bindResultToView()
            }
        }
    }
    
    var netWorkingDataSource : NetWorkingDataSource
    
    init(netWorkingDataSource: NetWorkingDataSource) {
        
        self.netWorkingDataSource = netWorkingDataSource
    }
    
    func loadAllLeagues(){
        netWorkingDataSource.loadDataFromAPI { [weak self] (result : LeagueResult?) in
            if let items = result?.result {
                
                self!.allSelctedSportLeagues = items
                
            }
        }
    }
}
