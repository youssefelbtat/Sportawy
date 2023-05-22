//
//  HomeScreen.swift
//  Sportawy
//
//  Created by Mac on 17/05/2023.
//

import UIKit

class HomeScreen: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
       
    @IBOutlet weak var sportsCollectionView: UICollectionView!
    var homeViewModel : HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel = HomeViewModel()
        sportsCollectionView.dataSource = self
        sportsCollectionView.delegate = self
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return homeViewModel.allSorts.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (UIScreen.main.bounds.size.width / 2 ) - 10, height: 180)
        

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sportscell", for: indexPath) as! SportsCollectionsCell
        
        cell.widthImageConstrin.constant = UIScreen.main.bounds.width / 2 - 5
        cell.imgSportCell.image = UIImage(named: "\(homeViewModel.allSorts[indexPath.row])")
        cell.labSportTitle.text = homeViewModel.allSorts[indexPath.row].rawValue
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       
        if homeViewModel.checkInternetConnectivity(){
            
            if indexPath.row < 4 {
                let sec = self.storyboard?.instantiateViewController(withIdentifier: "leaguesScreen") as! LeaguesListScreen
                
                var selectedSportUrl : String!
                switch indexPath.row {
                case 0:
                    //"https://apiv2.allsportsapi.com/football/?met=Fixtures&leagueId=\(String( strKey))&from=2023-01-01&to=2023-05-20&APIkey=31db8d4ada7770ceee6a59e49db726464f20538721615b14b40170d55749ba82")
                    selectedSportUrl = "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=31db8d4ada7770ceee6a59e49db726464f20538721615b14b40170d55749ba82"
                case 1:
                    selectedSportUrl = "https://apiv2.allsportsapi.com/basketball/?met=Leagues&APIkey=31db8d4ada7770ceee6a59e49db726464f20538721615b14b40170d55749ba82"
                    
                case 2:
                    selectedSportUrl = "https://apiv2.allsportsapi.com/cricket/?met=Leagues&APIkey=31db8d4ada7770ceee6a59e49db726464f20538721615b14b40170d55749ba82"
                case 3:
                    selectedSportUrl = "https://apiv2.allsportsapi.com/tennis/?met=Leagues&APIkey=31db8d4ada7770ceee6a59e49db726464f20538721615b14b40170d55749ba82"
               
                default:
                    AlertType.comingSoon.showAlert(in: self)
                }
                
                sec.strUrl = selectedSportUrl
                navigationController?.pushViewController(sec, animated: true)
            }else{
                AlertType.comingSoon.showAlert(in: self)
            }
            
        }else{
            AlertType.noInternet.showAlert(in: self)
        }
        
   }
    
    
}
