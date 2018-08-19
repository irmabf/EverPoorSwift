//
//  AppDelegate.swift
//  NotesCD
//
//  Created by Irma Blanco on 15/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    //  Setup UIAppearance proxy
    UINavigationBar.appearance().tintColor = .white
    UINavigationBar.appearance().isTranslucent = false
    UINavigationBar.appearance().barTintColor = .darkGrey
    //    UINavigationBar.appearance().prefersLargeTitles = true
    //
    UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
    
    UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
    
    window = UIWindow()
    window?.makeKeyAndVisible()
    
    let noteController = NoteListController()
    
    let navController = CustomNavigationController(rootViewController: noteController)
    
    window?.rootViewController  = navController
    
    return true
  }
}

