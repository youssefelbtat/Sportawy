//
//  FavoriteViewModel.swift
//  Sportawy
//
//  Created by Mac on 19/05/2023.
//

import Foundation

class FavoriteViewModel{
    
    var bindResultToView : (()->()) = {}
    
    var allFavSports : [LeagueItem] = [] {
        didSet{
            DispatchQueue.main.async {
                self.bindResultToView()
            }
        }
    }
    
    var databaseInstance : CoreDataLocalDataSource
    
    init(databaseInstance: CoreDataLocalDataSource) {
        
        self.databaseInstance = databaseInstance
    }
    
    func loadCachingData(){
        
        self.allFavSports = databaseInstance.loadDataFromDB()
    }
    
    func deleteFavItem(itemKey : Int){
        
        self.databaseInstance.removeItemToDatabase(league_key: itemKey)
        
        self.loadCachingData()
    }
    
    func convertStringToSport(sportName : String) -> SportType?{
        
        return Converts().convertStringToSport(fromString: sportName)
        
    }
    
    
}
