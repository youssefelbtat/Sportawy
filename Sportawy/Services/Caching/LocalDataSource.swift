//
//  LocalDataSource.swift
//  Sportawy
//
//  Created by Mac on 19/05/2023.
//

import Foundation

protocol LocalDataSource {
    
    func insertItemToDatabase(item: LeagueItem)
    func removeItemToDatabase(league_key : Int)
    func loadDataFromDB() -> [LeagueItem]
}
