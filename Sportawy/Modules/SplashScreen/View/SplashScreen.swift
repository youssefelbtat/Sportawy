//
//  SplashScreen.swift
//  Sportawy
//
//  Created by Mac on 19/05/2023.
//

import UIKit
import Lottie
class SplashScreen: UIViewController {

    @IBOutlet weak var splashAnamationView: LottieAnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        splashAnamationView.contentMode = .scaleAspectFit
        splashAnamationView.loopMode = .loop
        splashAnamationView.animationSpeed = 0.6
        splashAnamationView.play()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                    self.showTabBarScreen()
                }

    }
    
    private func showTabBarScreen() {
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           guard let nav = storyboard.instantiateViewController(withIdentifier: "nav") as? UINavigationController else {
               return
           }
            nav.modalPresentationStyle = .fullScreen
           self.present(nav, animated: true, completion: nil)
       }

}
