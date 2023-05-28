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
    var addOrRemoveFavItem : ()->() = {}
    var youtubeObsearveAction : ()->() = {}
    override func awakeFromNib() {
        super.awakeFromNib()
        btnfav.setTitle("", for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupCell(item : LeagueItem!){
        self.lblLeagueName?.text = item.league_name
        self.lblLeagueCounty?.text = item.country_name
        
        ImageUtilites.downloadImageUsingKF(withUrl: item.league_logo ?? "", andPlaceholder: "Leagues", inSize: CGSize(width: 90, height: 90), showIn: self.leagueImage)
    }
    
    @IBAction func btnYoutubeVideoAction(_ sender: Any) {
        self.youtubeObsearveAction()
    }
    
    @IBAction func btnFavAction(_ sender: Any) {
        self.addOrRemoveFavItem()
    }
    
    func setFavUI(isFav:Bool){
        var image:UIImage!
        if isFav{
             image = UIImage(systemName: "heart.fill")
             btnfav.setImage(image, for: .normal)
            
        }else{
             image = UIImage(systemName: "heart")
             btnfav.setImage(image, for: .normal)
        }
       
    }
}
