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
             
                sec.sportType = homeViewModel.allSorts[indexPath.row]
                
                navigationController?.pushViewController(sec, animated: true)
                
            }else{
                AlertType.comingSoon.showAlert(in: self)
            }
            
        }else{
            AlertType.noInternet.showAlert(in: self)
        }
        
   }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (UIScreen.main.bounds.size.width / 2 ) - 10, height: 180)
        

    }
    
    
}
