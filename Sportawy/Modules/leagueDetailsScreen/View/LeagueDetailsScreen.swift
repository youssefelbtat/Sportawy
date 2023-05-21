//
//  LeagueDetailsScreen.swift
//  Sportawy
//
//  Created by Mac on 21/05/2023.
//

import UIKit

class LeagueDetailsScreen: UIViewController ,  UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var detailsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.detailsCollectionView.delegate = self
        self.detailsCollectionView.dataSource = self
        
        self.detailsCollectionView.register(CollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")

        
        let layout = UICollectionViewCompositionalLayout{index, environment in
            if index == 0{
                return DrawSection.drawEventSection()
            }else if index == 1{
                return DrawSection.drawLatestResultSection()
            
            }else{
                return DrawSection.drawTeamsSection()
            }
        }
        detailsCollectionView.setCollectionViewLayout(layout, animated: true)
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! CollectionViewHeader
            switch indexPath.section{
            case 0 :
                header.lblSectionHeader.text = "UPComingEvents"
                return header
            case 1:
                header.lblSectionHeader.text = "Leatest Results"
                return header
            default :
                header.lblSectionHeader.text = "Teams"
                return header
            }
            
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventcell", for: indexPath) as! EventAndResultsCell
            
            cell.firstImage.image = UIImage(named: "football")
            cell.secImage.image = UIImage(named: "baseball")
            cell.lblDate.text = "05-20-2022"
            cell.lblTime.text = "20:00"
            cell.lblSecTeamName.text = "Second Team"
            cell.lblFirstTeamName.text = "First Team"
            
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventcell", for: indexPath) as! EventAndResultsCell
            cell.firstImage.image = UIImage(named: "football")
            cell.secImage.image = UIImage(named: "baseball")
            cell.lblDate.text = "05-20-2022"
            cell.lblTime.text = "20:00"
            cell.lblSecTeamName.text = "Second Team"
            cell.lblFirstTeamName.text = "First Team"
            cell.lblAction.text = "3-0"
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamcell", for: indexPath) as! TeamCollectionViewCell
            cell.lblTeamName.text = "Team neame"
            cell.imgTeam.image = UIImage(named: "basketball")
            return cell
        }
    }
    



}
