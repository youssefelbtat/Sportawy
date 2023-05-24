//
//  TeamDetilsViewModel.swift
//  Sportawy
//
//  Created by Mac on 23/05/2023.
//

import Foundation

class TeamDetailsViewModel{
    
    var bindDataToView : (()->()) = {}
    var netWorkingDataSource : NetWorkingDataSource
    
    var TeamDetailsArray : [Team] = []{
        
        didSet{
            DispatchQueue.main.async {
                self.bindDataToView()
            }
            
        }
        
    }
    
    init( netWorkingDataSource: NetWorkingDataSource) {
        
        self.netWorkingDataSource = netWorkingDataSource
    }
    
    func loadTeamData(){
        
        netWorkingDataSource.loadDataFromAPI{ [weak self] (result: TeamResponse?) in
            if let items = result?.result{
                
                self?.TeamDetailsArray = items
            }
            
        }
        
    }
    
    
}
