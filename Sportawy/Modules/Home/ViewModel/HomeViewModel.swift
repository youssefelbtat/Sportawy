//
//  HomeViewModel.swift
//  Sportawy
//
//  Created by Mac on 19/05/2023.
//

import Foundation

class HomeViewModel {
    
    let allSorts = HomeSportsModel.allSports
    
    func checkInternetConnectivity()->Bool{
        
        return Connectivity.sharedInstance.isConnectedToInternet()
    }
    
    
}
