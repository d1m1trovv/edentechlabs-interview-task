//
//  TabBarController.swift
//  edentechlabs-interview-task
//
//  Created by Admin on 14.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation
import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        selectedIndex = 0
    }
    
    func appendNavigationController(_ rootController: UIViewController,
                                    _ title: String,
                                    image: UIImage) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootController)
        
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        navigationController.navigationBar.prefersLargeTitles = true
        rootController.navigationItem.title = title
        
        return navigationController
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let navController = viewController as? UINavigationController
        navController?.popToRootViewController(animated: true)
    }
}
