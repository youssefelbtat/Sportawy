//
//  LeaguesTableViewCell.swift
//  Sportawy
//
//  Created by Mac on 19/05/2023.
//

import UIKit

class LeaguesTableViewCell: UITableViewCell {

    @IBOutlet weak var lblLeagueCounty: UILabel!
    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var lblLeagueName: UILabel!
    @IBOutlet weak var btnfav: UIButton!
    
    @IBOutlet weak var btnYoutubeVideo: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func btnYoutubeVideoAction(_ sender: Any) {
        
    }
    
    @IBAction func btnFavAction(_ sender: Any) {
    }
}
