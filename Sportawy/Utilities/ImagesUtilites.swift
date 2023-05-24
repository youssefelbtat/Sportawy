//
//  UtilitiesViews.swift
//  Sportawy
//
//  Created by Mac on 19/05/2023.
//

import Foundation
import UIKit
import Kingfisher
class ImageUtilites {
 
    static func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        let resizedImage = renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: targetSize))
        }
        return resizedImage
    }
    
    static func downloadImageUsingKF(withUrl: String , andPlaceholder : String , inSize : CGSize , showIn : UIImageView!){
        let imageUrl = URL(string: withUrl)
        
        let resizedImage = ImageUtilites.resizeImage(image: UIImage(named: andPlaceholder)!, targetSize: inSize)
        
        let processor = DownsamplingImageProcessor(size: inSize ) |> RoundCornerImageProcessor(cornerRadius: 10)
        showIn!.kf.indicatorType = .activity
        
        showIn!.kf.setImage(
            with: imageUrl,
            placeholder: resizedImage,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        
    }

}
