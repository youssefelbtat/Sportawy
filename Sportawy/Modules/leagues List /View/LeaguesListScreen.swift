//
//  LeaguesListScreen.swift
//  Sportawy
//
//  Created by Mac on 19/05/2023.
//

import UIKit
import Kingfisher

class LeaguesListScreen : UIViewController , UITableViewDelegate , UITableViewDataSource {
   
    
    @IBOutlet weak var leaguesTableView: UITableView!
    
    var viewModel: LeaguesListViewModel!
    
    @IBOutlet weak var searchbar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leaguesTableView.dataSource = self
        leaguesTableView.delegate = self
        viewModel = LeaguesListViewModel(netWorkingDataSource: AlamofireNetworkingDataSource(
            url: "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=31db8d4ada7770ceee6a59e49db726464f20538721615b14b40170d55749ba82" ))
        
        viewModel.loadAllLeagues()
        
        viewModel.bindResultToView = { [weak self] in
            
            self?.leaguesTableView.reloadData()
            
        }

       
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.allSelctedSportLeagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "legcell")

        cell.textLabel?.text = viewModel.allSelctedSportLeagues[indexPath.row].league_name
        
        cell.detailTextLabel?.text = viewModel.allSelctedSportLeagues[indexPath.row].country_name
        
        let url = URL(string: viewModel.allSelctedSportLeagues[indexPath.row].league_logo ?? "") 
        
        cell.imageView!.kf.indicatorType = .activity
        
        cell.imageView!.kf.setImage(
            with: url,
            placeholder: UIImage(named: "Leagues"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        
        return cell
    }

   

}
