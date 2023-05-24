//
//  TeamDetailsScreen.swift
//  Sportawy
//
//  Created by Mac on 23/05/2023.
//

import UIKit

class TeamDetailsScreen: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    var sportType : SportType!
    var teamId : String!
    var indicator : UIActivityIndicatorView!
    var viewModel : TeamDetailsViewModel!
    @IBOutlet weak var imgTeam: UIImageView!
    @IBOutlet weak var lblTameName: UILabel!
    @IBOutlet weak var playersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator = UIActivityIndicatorView(style: .large)
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        indicator.startAnimating()
        self.playersTableView.delegate = self
        self.playersTableView.dataSource = self
        
        viewModel = TeamDetailsViewModel(netWorkingDataSource: AlamofireNetworkingDataSource(url: URLCreator().createOneTeamURL(for: sportType, teamId: teamId)))
        
        print("The team Url : \(URLCreator().createOneTeamURL(for: sportType, teamId: teamId))")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        viewModel.loadTeamData()
        
        viewModel.bindDataToView = { [weak self ] in
            
            ImageUtilites.downloadImageUsingKF(
                withUrl: self?.viewModel.TeamDetailsArray.first?.teamLogo ?? "",
                andPlaceholder: "Leagues",
                inSize: CGSize(width: 120, height: 90),
                showIn: self?.imgTeam)
            self?.lblTameName.text = self?.viewModel.TeamDetailsArray.first?.teamName ?? ""
            self?.indicator.stopAnimating()
            self?.playersTableView.reloadData()
            
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.TeamDetailsArray.first?.players?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "playercell")
        
        cell.textLabel?.text = viewModel.TeamDetailsArray.first?.players?[indexPath.row].playerName
        
        cell.detailTextLabel?.text = viewModel.TeamDetailsArray.first?.players?[indexPath.row].playerAge
        
        ImageUtilites.downloadImageUsingKF(withUrl: viewModel.TeamDetailsArray.first?.players?[indexPath.row].playerImage ?? "", andPlaceholder: "Leagues", inSize: CGSize(width: 40, height: 40), showIn: cell.imageView)
        
        return cell
    }
    

 
}
