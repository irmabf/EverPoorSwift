//
//  LocationTabBarController.swift
//  NotesCD
//
//  Created by Irma Blanco on 27/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

class LocationTabBarController: UITabBarController {
  
  //  Custom Functions
  func setupViewControllers() {
    //home
    let locationController = templateNavController(unselectedImage: #imageLiteral(resourceName: "map-unselected"), selectedImage: #imageLiteral(resourceName: "map-selected"), rootViewController: CurrentLocationController())
    
    
    let tagLocationController = templateNavController(unselectedImage: #imageLiteral(resourceName: "tag-unselected"), selectedImage: #imageLiteral(resourceName: "tag-selected"), rootViewController: LocationsDetailController())
    //search
    
  
  
    tabBar.tintColor = .creamYellow
    
    viewControllers = [locationController, tagLocationController]
    
    //modify tab bar item insets
    guard let items = tabBar.items else { return }
    
    for item in items {
      item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViewControllers()
  }
  fileprivate func templateNavController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
    let viewController = rootViewController
    let navController = UINavigationController(rootViewController: viewController)
    navController.tabBarItem.image = unselectedImage
    navController.tabBarItem.selectedImage = selectedImage
    return navController
  }
}
