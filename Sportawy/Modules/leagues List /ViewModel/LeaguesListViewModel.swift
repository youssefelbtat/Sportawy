//
//  LeaguesListViewModel.swift
//  Sportawy
//
//  Created by Mac on 19/05/2023.
//


import Foundation

class LeaguesListViewModel {
    
    var bindDataToView : (()->()) = {}
    var netWorkingDataSource : NetWorkingDataSource
    var localDataSource : LocalDataSource
    
    
    var allSelctedSportLeagues : [LeagueItem] = [] {
        didSet{
            DispatchQueue.main.async {
                self.bindDataToView()
            }
        }
    }
    
    var allFavSports : [LeagueItem] = [] {
        
        didSet{
            DispatchQueue.main.async {
                self.bindDataToView()
            }
        }
    }
   
    
    init(netWorkingDataSource: NetWorkingDataSource, locaDataSource : LocalDataSource) {
        self.localDataSource = locaDataSource
        self.netWorkingDataSource = netWorkingDataSource
    }
    
    func loadAllLeagues(){
        netWorkingDataSource.loadDataFromAPI { [weak self] (result : LeagueResult?) in
            if let items = result?.result {
                
                self?.allSelctedSportLeagues = items
                
            }
        }
    }
    
    func loadAllFavLeagues(){
        
        self.allFavSports = localDataSource.loadDataFromDB()
    }
    
    func addToFav(item : LeagueItem){
        
        localDataSource.insertItemToDatabase(item: item)
        
        self.loadAllFavLeagues()
    }
    
    func removeFavItem(id : Int){
        
        localDataSource.removeItemToDatabase(league_key: id)
        
        self.loadAllFavLeagues()
        
    }
    
}
