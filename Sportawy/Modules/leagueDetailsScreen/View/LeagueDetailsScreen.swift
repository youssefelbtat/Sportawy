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
    
    
    var sportType : SportType!
    var leagueKey : String!
    var indicator : UIActivityIndicatorView!
    @IBOutlet weak var detailsCollectionView: UICollectionView!
    
    var viewModel: LeagueDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator = UIActivityIndicatorView(style: .large)
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        indicator.startAnimating()
        self.detailsCollectionView.delegate = self
        self.detailsCollectionView.dataSource = self
        
        
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
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel = LeagueDetailsViewModel(netWorkingDataSource: AlamofireNetworkingDataSource())
        
        viewModel.loadAllLeagueEvents(withUrl: URLCreator().createUpcomingEventsURL(for: sportType, leagueId: leagueKey))
        viewModel.loadAllLeagueLastResults(withUrl: URLCreator().createLatestResultsURL(for: sportType, leagueId: leagueKey))
        viewModel.loadAllLeagueTeams(withUrl: URLCreator().createTeamsURL(for: sportType, leagueId: leagueKey))
        
        print("The Teams Url: \(URLCreator().createTeamsURL(for: self.sportType, leagueId: self.leagueKey)) ")
        print("The Last Url: \(URLCreator().createLatestResultsURL(for: self.sportType, leagueId: self.leagueKey)) ")
        print("The Upcaming Url: \(URLCreator().createUpcomingEventsURL(for: self.sportType, leagueId: self.leagueKey)) ")
        
        viewModel.bindDataToView = { [weak self] in
            self?.indicator.stopAnimating()
            self?.detailsCollectionView.reloadData()
            
        }
        
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
            
            let fImageUrl = viewModel.allLeagueEvents[indexPath.row].firstTeamLogo ?? ""
            
            let sImageUrl = viewModel.allLeagueEvents[indexPath.row].secondTeamLogo ?? ""
                        
            ImageUtilites.downloadImageUsingKF(
                withUrl: fImageUrl ,
                andPlaceholder: "Leagues",
                inSize: CGSize(width: 90, height: 90), showIn: cell.firstImage)
            
            ImageUtilites.downloadImageUsingKF(
                withUrl: sImageUrl,
                andPlaceholder: "Leagues",
                inSize: CGSize(width: 90, height: 90), showIn: cell.secImage)
           
            cell.lblDate.text = viewModel.allLeagueEvents[indexPath.row].eventDate
            cell.lblTime.text = viewModel.allLeagueEvents[indexPath.row].eventTime
            cell.lblSecTeamName.text = viewModel.allLeagueEvents[indexPath.row].secondTeamName
            cell.lblFirstTeamName.text = viewModel.allLeagueEvents[indexPath.row].firstTeamName
            
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventcell", for: indexPath) as! EventAndResultsCell
            
            let fImageUrl = viewModel.allLeagueLastResults[indexPath.row].firstTeamLogo ?? ""
            
            let sImageUrl = viewModel.allLeagueLastResults[indexPath.row].secondTeamLogo ?? ""
            
            let resizedImage = ImageUtilites.resizeImage(image: UIImage(named: "Leagues")!, targetSize: CGSize(width: 60, height: 60))
            
            ImageUtilites.downloadImageUsingKF(
                withUrl: fImageUrl,
                andPlaceholder: "Leagues",
                inSize: CGSize(width: 90, height: 90), showIn: cell.firstImage)
            
            ImageUtilites.downloadImageUsingKF(
                withUrl: sImageUrl,
                andPlaceholder: "Leagues",
                inSize: CGSize(width: 90, height: 90), showIn: cell.secImage)
           
            cell.lblDate.text = viewModel.allLeagueLastResults[indexPath.row].eventDate
            cell.lblTime.text = viewModel.allLeagueLastResults[indexPath.row].eventTime
            cell.lblSecTeamName.text = viewModel.allLeagueLastResults[indexPath.row].secondTeamName
            cell.lblFirstTeamName.text = viewModel.allLeagueLastResults[indexPath.row].firstTeamName
            cell.lblAction.text = viewModel.allLeagueLastResults[indexPath.row].eventFinalResult
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamcell", for: indexPath) as! TeamCollectionViewCell
            cell.lblTeamName.text = viewModel.allLeagueTeams[indexPath.row].teamName
            ImageUtilites.downloadImageUsingKF(
                withUrl: viewModel.allLeagueTeams[indexPath.row].teamLogo ?? "",
                andPlaceholder: "Leagues",
                inSize: CGSize(width: 90, height: 90), showIn: cell.imgTeam)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 2 {
            
            let sec = storyboard?.instantiateViewController(withIdentifier: "teamdetailssec") as! TeamDetailsScreen
            
            sec.sportType = sportType
            sec.teamId = "\(viewModel.allLeagueTeams[indexPath.row].teamKey ?? 0)"
            sec.modalPresentationStyle = .fullScreen
            
            self.present(sec, animated: true)
            
        }
    }
    



}
