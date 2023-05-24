//
//  CoreDataLocalDataSource.swift
//  Sportawy
//
//  Created by Mac on 19/05/2023.
//

import Foundation
import CoreData
import UIKit

class CoreDataLocalDataSource : LocalDataSource {
    
    static let instance = CoreDataLocalDataSource()
    
    private let entityName = "LeagueItemEntity"
    private var contextManager : NSManagedObjectContext!
    private var itemsNS : [NSManagedObject] = []
    private init(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        contextManager = appDelegate.persistentContainer.viewContext
    }
    
    

    func loadDataFromDB() -> [LeagueItem] {
        
        
        
        let fetch = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        var items = [LeagueItem]()
        
        do{
            itemsNS = try contextManager.fetch(fetch)
            
            for item in itemsNS{
                let league_key = item.value(forKey: "league_key") as? Int
                let league_logo = item.value(forKey: "league_logo") as? String
                let league_name = item.value(forKey: "league_name") as? String
                let country_name = item.value(forKey: "country_name") as? String
                let country_key = item.value(forKey: "country_key") as? Int
                let country_logo = item.value(forKey: "country_logo") as? String
                let league_Type = item.value(forKey: "league_type") as? String
                let item = LeagueItem(country_key: country_key, country_name: country_name, league_key: league_key, league_logo: league_logo, country_logo: country_logo, league_name: league_name , league_type: league_Type)
                items.append(item)
            }
       
        }catch let error{
            print("Error when fetch all data : \(error.localizedDescription)")
        }
       
       return items
    
    }
    
    
    
    func insertItemToDatabase(item: LeagueItem) {
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: contextManager)
        
        let itemEntity = NSManagedObject(entity: entity!, insertInto: contextManager)
        
        print("The logo in insert  : \(item.league_logo)")
        itemEntity.setValue(item.league_key, forKey: "league_key")
        if item.league_logo == nil {
            print("Non for league")
            itemEntity.setValue("Non", forKey: "league_logo")
        }else{
            print("league is not null \(item.league_logo)")
            itemEntity.setValue(item.league_logo, forKey: "league_logo")
        }
        itemEntity.setValue(item.league_name, forKey: "league_name")
        itemEntity.setValue(item.country_name, forKey: "country_name")
        itemEntity.setValue(item.country_key, forKey: "country_key")
        itemEntity.setValue(item.league_type, forKey: "league_type")
        
        if item.country_logo == nil {
            print("Non for cou")
            itemEntity.setValue("Non", forKey: "country_logo")
        }else{
            print("cou is not null")
            itemEntity.setValue(item.country_logo, forKey: "country_logo")
        }
        
        do{
            try contextManager.save()
            print("The Items with id \(item.league_key!) added to fav successfully .")
        }catch let e{
            print("Error when add item to fav  : \(e.localizedDescription)")
        }
    }
    
    
    
    
    func removeItemToDatabase(league_key: Int) {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        fetch.predicate = NSPredicate(format: "league_key == %d", league_key)
        
        do {
            let fetchResults = try contextManager.fetch(fetch) as? [NSManagedObject]
            if let item = fetchResults?.first {
                contextManager.delete(item)
                try contextManager.save()
                print("Item with id \(league_key) deleted successfully")
            }
        } catch let error {
            print("Error deleting Item with id \(league_key): \(error.localizedDescription)")
        }
        
    }
    
    
}
