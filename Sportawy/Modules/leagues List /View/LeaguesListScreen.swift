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
        
        let nib = UINib(nibName: "LeaguesTableViewCell", bundle: nil)
        leaguesTableView.register(nib, forCellReuseIdentifier: "cell")
        
        viewModel.bindResultToView = { [weak self] in
            
            self?.leaguesTableView.reloadData()
            
        }

       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.allSelctedSportLeagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeaguesTableViewCell

        cell.lblLeagueName?.text = viewModel.allSelctedSportLeagues[indexPath.row].league_name
        
        cell.lblLeagueCounty?.text = viewModel.allSelctedSportLeagues[indexPath.row].country_name
        
        let imageUrl = URL(string: viewModel.allSelctedSportLeagues[indexPath.row].league_logo ?? "")
        
        let resizedImage = UtilitiesViews.resizeImage(image: UIImage(named: "Leagues")!, targetSize: CGSize(width: 90, height: 90))
        
        let processor = DownsamplingImageProcessor(size: CGSize(width: 90, height: 90) ) |> RoundCornerImageProcessor(cornerRadius: 10)
        cell.leagueImage!.kf.indicatorType = .activity
        
        cell.leagueImage!.kf.setImage(
            with: imageUrl,
            placeholder: resizedImage,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        
        return cell
    }

   

}
