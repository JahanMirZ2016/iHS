//
//  SecondPageTBC.swift
//  iHS Swift
//
//  Created by arash on 11/9/16.
//  Copyright © 2016 Ali Zare Sh. All rights reserved.
//


/*
 Arash : Section2 - Class For Managing UITabbarController in Section 2
 */

import UIKit
import CoreLocation

class SecondPageTBC: UITabBarController , CLLocationManagerDelegate {
    
    var locationManager:CLLocationManager?
    var selectedImageArray:[String] = ["Favorite" , "Node" , "Scenario" , "Setting"]
    var unselectedImageArray:[String] = ["FavoriteA" , "NodeA" , "ScenarioA" , "SettingA"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        selectItemImage()
        setUpTabBar()
        setItemNames(DBManager.getTranslationOfSentences(SentencesID: [1 , 9 , 10 , 4]))

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// Arash :Set Tabbar Height
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = 80
        tabFrame.origin.y = self.view.frame.size.height - 80
        self.tabBar.frame = tabFrame
        
    }
    
    /// Arash: Set Tabbar Item Images
    func selectItemImage() {
        if let count = self.tabBar.items?.count {
            for i in 0...(count-1) {
                let imageNameForSelectedState = selectedImageArray[i]
                let imageNameForUnselectedState = unselectedImageArray[i]
                self.tabBar.items?[i].selectedImage = UIImage(named: imageNameForSelectedState)
                self.tabBar.items?[i].image = UIImage(named: imageNameForUnselectedState)
            }
        }
        let color = UIColor.whiteColor()
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: color] , forState: .Normal )
        
    }
    
    /// Arash: Set Tabbar Item Titles For Each Language.
    func setItemNames(nameArray : Array<String>) {
        if let count = self.tabBar.items?.count {
            for i in 0...(count-1) {
                self.tabBar.items?[i].title = nameArray[i]
            }
        }
    }
    
    
    /// Arash: Setup Tabbar (remove shadowImage, set backgroundImage and ...)
    func setUpTabBar() {
        UITabBar.appearance().barTintColor = UIColor.whiteColor()
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage(named: "tab-bar-bg")
    }
  
}
