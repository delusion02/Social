//
//  MainTabBarController.swift
//  Social
//
//  Created by Сергей Кулагин on 25.06.2021.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    func setupUser() -> [Friends] {
        var resultArray = [Friends]()
    
        let firstPhotoArray = [UIImage(named: "lj1")!, UIImage(named: "lj2")!, UIImage(named: "lj3")!]
        let firstUser = Friends(name: "LeBron James", avatar: UIImage(named: "lj1")!, photoArray: firstPhotoArray, description: "Cleveland, Ohio")
            resultArray.append(firstUser)
        let secondPhotoArray = [UIImage(named: "k1")!, UIImage(named: "k2")!, UIImage(named: "k3")!]
        let secondUser = Friends(name: "Kobe Bryant", avatar: UIImage(named: "k1")!, photoArray: secondPhotoArray, description: "Philadelphia, Pennsylvania")
        resultArray.append(secondUser)
        
        return resultArray
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let friendsNavigationController = self.viewControllers?.first as? UINavigationController,
        let friendViewController = friendsNavigationController.viewControllers.first as? FriendsViewController {
            friendViewController.configure(userArray: setupUser())
        }
    }
}
