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

        cell.lblLeagueName?.text = viewModel.allFavSports[indexPath.row].league_name
        
        cell.lblLeagueCounty?.text = viewModel.allFavSports[indexPath.row].country_name
        
        let imageUrl = URL(string: viewModel.allFavSports[indexPath.row].league_logo ?? "")
        
        let resizedImage = ImageUtilites.resizeImage(image: UIImage(named: "Leagues")!, targetSize: CGSize(width: 90, height: 90))
        
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
        
        cell.itemToAddToFav = viewModel.allFavSports[indexPath.row]
    
            cell.isFavorite = true
            cell.btnfav.setImage(UIImage(systemName: "heart.fill"),for: .normal)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
                self.viewModel.deleteFavItem(itemKey: viewModel.allFavSports[indexPath.row].league_key!)
            
            favTableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
    }
    
   

}
