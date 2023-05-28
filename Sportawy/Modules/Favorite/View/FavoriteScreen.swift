//
//  FavoriteScreen.swift
//  Sportawy
//
//  Created by Mac on 17/05/2023.
//

import UIKit
import Kingfisher

class FavoriteScreen: UIViewController , UITableViewDelegate , UITableViewDataSource {
   
    @IBOutlet weak var lblNoItems: UILabel!
    @IBOutlet weak var btnBackToAddFav: UIButton!
    @IBOutlet weak var favTableView: UITableView!
    
    var viewModel: FavoriteViewModel!
    
    override func viewDidLoad() {
        let nib = UINib(nibName: "LeaguesTableViewCell", bundle: nil)
        favTableView.register(nib, forCellReuseIdentifier: "cell")
        
        favTableView.dataSource = self
        favTableView.delegate = self
        
        viewModel = FavoriteViewModel(databaseInstance: CoreDataLocalDataSource.instance)

        
        viewModel.bindResultToView = { [weak self] in
            
            if self!.viewModel.allFavSports.isEmpty
            {
                self?.favTableView.isHidden = true
                self?.btnBackToAddFav.isHidden = false
                self?.lblNoItems.isHidden = false
              
            }else{
                self?.favTableView.isHidden = false
                self?.btnBackToAddFav.isHidden = true
                self?.lblNoItems.isHidden = true
                self?.favTableView.reloadData()
            }
        }
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadCachingData()
    }
    

    @IBAction func backToAddFavAction(_ sender: Any) {
        
        if let tab = self.tabBarController {
            tab.selectedIndex = 0
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.allFavSports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeaguesTableViewCell

        cell.setupCell(item: viewModel.allFavSports[indexPath.row])
        cell.setFavUI(isFav: true)
        cell.addOrRemoveFavItem = { [weak self] in
            AlertType.confirmRemove(deleteHandler: {
                self?.viewModel.deleteFavItem(itemKey: self?.viewModel.allFavSports[indexPath.row].league_key ?? -1)
            }).showAlert(in: self!)
            
            
        }
        cell.youtubeObsearveAction = { [weak self] in
            
            AlertType.comingSoon.showAlert(in: self!)
            
        }
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            AlertType.confirmRemove(deleteHandler: {
                self.viewModel.deleteFavItem(itemKey: self.viewModel.allFavSports[indexPath.row].league_key!)
                self.favTableView.deleteRows(at: [indexPath], with: .automatic)
            }).showAlert(in: self)
                
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if viewModel.checkInternetConnectivity(){
            let sec = storyboard?.instantiateViewController(withIdentifier: "legdetails") as! LeagueDetailsScreen
            
        
            let league = viewModel.allFavSports[indexPath.row]
            
            sec.leagueKey = "\(league.league_key ?? 0)"
            sec.sportType = viewModel.convertStringToSport(sportName: league.league_type ?? "" )
            sec.modalPresentationStyle = .fullScreen
            self.present(sec, animated: true, completion: nil)
        }else{
            AlertType.noInternet.showAlert(in: self)
        }
        
       
    }
    
    
    
   

}
