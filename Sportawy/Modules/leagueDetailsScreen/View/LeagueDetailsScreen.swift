//
//  LeagueDetailsScreen.swift
//  Sportawy
//
//  Created by Mac on 21/05/2023.
//


/*https://apiv2.allsportsapi.com/football?met=Fixtures&leagueId=205&from=2022-01-18&to=2023-01-18&APIkey=*/

import UIKit
import Kingfisher
class LeagueDetailsScreen: UIViewController ,  UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    var strKey : Int!
    
    @IBOutlet weak var detailsCollectionView: UICollectionView!
    
    var viewModel: LeagueDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.detailsCollectionView.delegate = self
        self.detailsCollectionView.dataSource = self
        
        
        viewModel = LeagueDetailsViewModel(netWorkingDataSource: AlamofireNetworkingDataSource())
        
        viewModel.loadAllLeagueEvents(withUrl: "https://apiv2.allsportsapi.com/football/?met=Fixtures&leagueId=\(String( strKey))&from=2023-05-22&to=2024-05-22&APIkey=31db8d4ada7770ceee6a59e49db726464f20538721615b14b40170d55749ba82")
        viewModel.loadAllLeagueLastResults(withUrl: "https://apiv2.allsportsapi.com/football/?met=Fixtures&leagueId=\(String( strKey))&from=2023-01-01&to=2023-05-20&APIkey=31db8d4ada7770ceee6a59e49db726464f20538721615b14b40170d55749ba82")
        
        viewModel.bindDataToView = { [weak self] in
            
            self?.detailsCollectionView.reloadData()
            
        }
        
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
        
        switch section {
        case 0:
            return viewModel.allLeagueEvents.count
        case 1:
            return viewModel.allLeagueLastResults.count
        case 2:
            return viewModel.allLeagueTeams.count
        default:
            return 0
        }
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
            
            let fImageUrl = URL(string: viewModel.allLeagueEvents[indexPath.row].firstTeamLogo )
            
            let sImageUrl = URL(string: viewModel.allLeagueEvents[indexPath.row].secondTeamLogo )
            
            let resizedImage = UtilitiesViews.resizeImage(image: UIImage(named: "Leagues")!, targetSize: CGSize(width: 60, height: 60))
            
            let processor = DownsamplingImageProcessor(size: CGSize(width: 60, height: 60) ) |> RoundCornerImageProcessor(cornerRadius: 10)
            cell.firstImage!.kf.indicatorType = .activity
            
            cell.firstImage!.kf.setImage(
                with: fImageUrl,
                placeholder: resizedImage,
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
            
            cell.secImage!.kf.setImage(
                with: sImageUrl,
                placeholder: resizedImage,
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
           
            cell.lblDate.text = viewModel.allLeagueEvents[indexPath.row].eventDate
            cell.lblTime.text = viewModel.allLeagueEvents[indexPath.row].eventTime
            cell.lblSecTeamName.text = viewModel.allLeagueEvents[indexPath.row].secondTeamName
            cell.lblFirstTeamName.text = viewModel.allLeagueEvents[indexPath.row].firstTeamName
            
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventcell", for: indexPath) as! EventAndResultsCell
            let fImageUrl = URL(string: viewModel.allLeagueLastResults[indexPath.row].firstTeamLogo )
            
            let sImageUrl = URL(string: viewModel.allLeagueLastResults[indexPath.row].secondTeamLogo )
            
            let resizedImage = UtilitiesViews.resizeImage(image: UIImage(named: "Leagues")!, targetSize: CGSize(width: 60, height: 60))
            
            let processor = DownsamplingImageProcessor(size: CGSize(width: 60, height: 60) ) |> RoundCornerImageProcessor(cornerRadius: 10)
            cell.firstImage!.kf.indicatorType = .activity
            
            cell.firstImage!.kf.setImage(
                with: fImageUrl,
                placeholder: resizedImage,
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
            
            cell.secImage!.kf.setImage(
                with: sImageUrl,
                placeholder: resizedImage,
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
           
            cell.lblDate.text = viewModel.allLeagueLastResults[indexPath.row].eventDate
            cell.lblTime.text = viewModel.allLeagueLastResults[indexPath.row].eventTime
            cell.lblSecTeamName.text = viewModel.allLeagueLastResults[indexPath.row].secondTeamName
            cell.lblFirstTeamName.text = viewModel.allLeagueLastResults[indexPath.row].firstTeamName
            cell.lblAction.text = viewModel.allLeagueLastResults[indexPath.row].eventFinalResult
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamcell", for: indexPath) as! TeamCollectionViewCell
            cell.lblTeamName.text = "Team neame"
            cell.imgTeam.image = UIImage(named: "basketball")
            return cell
        }
    }
    



}
