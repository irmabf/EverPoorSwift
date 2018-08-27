//
//  MainTabBarController.swift
//  NotesCD
//
//  Created by Irma Blanco on 27/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
  
  //  Custom Functions
  func setupViewControllers() {
  
    //Here we get a location and tag it
    let locationController = templateNavController(unselectedImage: #imageLiteral(resourceName: "map-unselected"), selectedImage: #imageLiteral(resourceName: "map-selected"), rootViewController: CurrentLocationController())
    
//    let locationsDetailController = templateNavController(unselectedImage: #imageLiteral(resourceName: "info-unselected"), selectedImage: #imageLiteral(resourceName: "info-unselected"), rootViewController: LocationsDetailController())
//
     //Here we see the detail screen of locations
    let locationsDetailController = templateNavController(unselectedImage: #imageLiteral(resourceName: "info-unselected"), selectedImage: #imageLiteral(resourceName: "info-selected"), rootViewController: LocationsDetailController())
    
 
    viewControllers = [locationController, locationsDetailController]
    
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupViewControllers()
    setupUI()
  }
  fileprivate func templateNavController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
    let viewController = rootViewController
    let navController = UINavigationController(rootViewController: viewController)
    navController.tabBarItem.image = unselectedImage
    navController.tabBarItem.selectedImage = selectedImage
    return navController
  }

  
  fileprivate func setupUI() {
    tabBar.tintColor = .creamYellow
    //modify tab bar item insets
    guard let items = tabBar.items else { return }
    
    for item in items {
      item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
    }
  }
  
}
















