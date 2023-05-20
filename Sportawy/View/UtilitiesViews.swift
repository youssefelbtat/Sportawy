//
//  UtilitiesViews.swift
//  Sportawy
//
//  Created by Mac on 19/05/2023.
//

import Foundation
import UIKit

class UtilitiesViews {
 
    static func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        let resizedImage = renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: targetSize))
        }
        return resizedImage
    }

}
