//
//  LeaguesListScreen.swift
//  Sportawy
//
//  Created by Mac on 19/05/2023.
//



import UIKit
import Kingfisher


class LeaguesListScreen: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var viewModel: LeaguesListViewModel!
    var indicator: UIActivityIndicatorView!
    var sportType: SportType!
    var filteredList: [LeagueItem] = []

    
    @IBOutlet weak var leaguesTableView: UITableView!
    @IBOutlet weak var searchbar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator = UIActivityIndicatorView(style: .large)
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        indicator.startAnimating()
        
        leaguesTableView.dataSource = self
        leaguesTableView.delegate = self
        
        searchbar.delegate = self
        
        viewModel = LeaguesListViewModel(
            netWorkingDataSource: AlamofireNetworkingDataSource(url: URLCreator().createLeaguesURL(for: sportType)),
            locaDataSource: CoreDataLocalDataSource.instance)
        
        let nib = UINib(nibName: "LeaguesTableViewCell", bundle: nil)
        leaguesTableView.register(nib, forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // To Show The Indicator even if the internet is fast (:
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.viewModel.loadAllLeagues()
            self.viewModel.loadAllFavLeagues()
        })
        
        viewModel.bindDataToView = { [weak self] in
            self?.indicator.stopAnimating()
            self?.leaguesTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchbar.text?.isEmpty == false {
            return filteredList.count
        } else {
            return viewModel.allSelctedSportLeagues.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeaguesTableViewCell
        
        var league: LeagueItem
        if searchbar.text?.isEmpty == false {
            league = filteredList[indexPath.row]
        } else {
            league = viewModel.allSelctedSportLeagues[indexPath.row]
        }
        
        cell.lblLeagueName?.text = league.league_name
        cell.lblLeagueCounty?.text = league.country_name
        
        ImageUtilites.downloadImageUsingKF(
            withUrl: league.league_logo ?? "",
            andPlaceholder: "Leagues",
            inSize: CGSize(width: 90, height: 90),
            showIn: cell.leagueImage)
        
        league.league_type = sportType.rawValue.lowercased()
        cell.itemToAddToFav = league
        
        if viewModel.allFavSports.contains(where: { $0.league_key == league.league_key }) {
            cell.isFavorite = true
            cell.btnfav.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            cell.isFavorite = false
            cell.btnfav.setImage(UIImage(systemName: "heart"), for: .normal)
        }

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sec = storyboard?.instantiateViewController(withIdentifier: "legdetails") as! LeagueDetailsScreen
        
        let league: LeagueItem
        if searchbar.text?.isEmpty == false {
            league = filteredList[indexPath.row]
        } else {
            league = viewModel.allSelctedSportLeagues[indexPath.row]
        }
        
        sec.leagueKey = "\(league.league_key ?? 0)"
        sec.sportType = sportType
        sec.modalPresentationStyle = .fullScreen
        self.present(sec, animated: true, completion: nil)
    }
    
    // MARK: - UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredList = viewModel.allSelctedSportLeagues.filter { league in
            guard let leagueName = league.league_name else { return false }
            return leagueName.localizedCaseInsensitiveContains(searchText)
        }
        leaguesTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}



