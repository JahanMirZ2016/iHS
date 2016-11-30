//
//  AppDelegate.swift
//  iHS Swift
//
//  Created by Ali Zare Sh on 11/9/16.
//  Copyright © 2016 Ali Zare Sh. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate , RecieveSocketDelegate {
    
    var window: UIWindow?
    
    /// BinMan1 : A socket object for use in all of the project from appdelegate
    var socket : SocketManager!
    var network : Internet!
    
    /// BinMan1 : Action Bar Property
    var actionBar : TopBar? {
        set {
            actionBarView = newValue!
        }
        
        get {
            return actionBarView
        }
    }
    
    private var actionBarView = TopBar()
    
    /// BinMan1 : Choose the init view controller
    private func chooseVC () {
        if DBManager.getValueOfSettingsDB(Type: TypeOfSettings.Register) == "0" {
            let story = UIStoryboard(name: "Welcome", bundle: nil)
            let vc = story.instantiateViewControllerWithIdentifier("languageVC")
            window?.rootViewController = vc
            return
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.updateActionBar(_:)), name: ACTIONBAR_UPDATE_VIEW, object: nil)
        
        self.startCheckingInternet()
        let story = UIStoryboard(name: "Main", bundle: nil)
        let vc = story.instantiateViewControllerWithIdentifier("SecondPageTBC")
        window?.rootViewController = vc
    }
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        
        socket = SocketManager()
        socket.rDelegate = self
        
        /// BinMan1 : Set selected language id from db
        if let langID = DBManager.getValueOfSettingsDB(Type: TypeOfSettings.LanguageID) {
            SetLangIDToVar(Int(langID)!)
        } else {
            Printer("AppDelegate Error : Can't get Language ID From Settings Table of DB")
        }
        
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Alert , .Badge , .Sound], categories: nil))
        chooseVC()
        
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    /// BinMan1 : function for start reachability and checking and managing internet connections
    func startCheckingInternet () {
        network = Internet()
        network.checkNetwork()
    }
    
    /// Arash: Localnotification
    func showNotify(body : String) {
        
        let notification = UILocalNotification()
        notification.timeZone = NSTimeZone.defaultTimeZone()
        let dateTime = NSDate(timeIntervalSinceNow: 2)
        notification.fireDate = dateTime
        notification.alertBody = body
        notification.soundName = UILocalNotificationDefaultSoundName
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    /// BinMan1 : delegate function for get data and pass to datamanager
    func recieve(rData: NSString) {
        dispatch_async(dispatch_get_main_queue()) {
            DataManager.JSONAnalyzer(rData)
            Printer("khkhkhkh : \(rData)")
            
        }
    }
    
    
    /// BinMan1 : ActionBar Update View Observer
    @objc private func updateActionBar(notification : NSNotification) {
        let state = notification.object as! ActionBarState
        switch state {
        case .notify:
            actionBar!.messageCount = "\(DBManager.getAllNotSeenNotifies()!.count)"
            break
        case .noInternetConnection:
            actionBar!.connectionImage = UIImage(named: "icon_main_connection_status_disconnected")
            break
        case .localConnection:
            actionBar!.connectionImage = UIImage(named: "icon_main_connection_status_local")
            break
        case .globalConnection:
            actionBar!.connectionImage = UIImage(named: "icon_main_connection_status_server")
            break
        default:
            break
        }
    }
}

