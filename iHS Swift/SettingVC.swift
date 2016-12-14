//
//  SettingVC.swift
//  iHS Swift
//
//  Created by arash on 11/10/16.
//  Copyright © 2016 Ali Zare Sh. All rights reserved.
//


/*
 Arash : Section2 - Setting View Controller
 */

import UIKit

class SettingVC: UIViewController {
    
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var topBar: TopBar!
    @IBOutlet weak var outletEn: UIButton!
    @IBOutlet weak var outletIr: UIButton!
    @IBOutlet weak var outletAr: UIButton!
    @IBOutlet weak var outletTr: UIButton!
    let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topBar.viewController = self
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bgMain")!)
        setSelectedLangImage()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.updateView(_:)), name: SYNC_UPDATE_VIEW, object: nil)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        manageTopBar()
    }
    
    /// Arash: Reset all registers and go to LanguageVC.
    @IBAction func btnResetRegister(sender: UIButton) {
        DBManager.resetFactory()
        startAppAgain()
    }
    
    ///Arash: Delete all data and sync from center.
    @IBAction func selectorSync(sender: UIButton) {
        
        
        var jsonArray = Array<Dictionary<String,AnyObject>>()
        let recieverArray:NSArray = [DBManager.getValueOfSettingsDB(Type: TypeOfSettings.MobileID)!]
        let obj = Dictionary<String,AnyObject>()
        let objArray:NSArray = [obj]
        let jsonObject:Dictionary<String,AnyObject> = ["MessagID" : 0 , "Type" : "RefreshData" , "Action" : "Update" , "Date" : "2015-01-01 12:00:00" , "RecieverIDs" : recieverArray , "MobileName" : DBManager.getValueOfSettingsDB(Type: TypeOfSettings.CustomerName)! , "ExKey" : DBManager.getValueOfSettingsDB(Type: TypeOfSettings.ExKey)! , "RefreshData" : objArray]
        jsonArray.append(jsonObject)
        let json = JsonMaker.arrayToJson(jsonArray)
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        if appDel.socket != nil {
            if appDel.socket.state == .connectToLocal || appDel.socket.state == .connectToServer {
                DBManager.resetFactory()
                if appDel.socket.send(json) {
                    indicator.startAnimating()
                }
            }
        }
    }
    
    
    /// Arash : Language Buttons
    @IBAction func btnEn(sender: UIButton) {
        outletEn.setBackgroundImage(UIImage(named: "En"), forState: .Normal)
        outletAr.setBackgroundImage(UIImage(named: "ArGray"), forState: .Normal)
        outletIr.setBackgroundImage(UIImage(named: "FaGray"), forState: .Normal)
        outletTr.setBackgroundImage(UIImage(named: "TrGray"), forState: .Normal)
        DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.LanguageID, UpdateValue: String(LangID.ENGLISH))
        SetLangIDToVar(LangID.ENGLISH)
        // Arash : Change tabbar language.
        (appDel.window?.rootViewController as! SecondPageTBC).setItemNames(DBManager.getTranslationOfSentences(SentencesID: [1 , 9 , 10 , 4]))
        
    }
    
    @IBAction func btnIr(sender: UIButton) {
        outletIr.setBackgroundImage(UIImage(named: "Fa"), forState: .Normal)
        outletEn.setBackgroundImage(UIImage(named: "EnGray"), forState: .Normal)
        outletAr.setBackgroundImage(UIImage(named: "ArGray"), forState: .Normal)
        outletTr.setBackgroundImage(UIImage(named: "TrGray"), forState: .Normal)
        DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.LanguageID, UpdateValue: String(LangID.PERSIAN))
        SetLangIDToVar(LangID.PERSIAN)
        // Arash : Change tabbar language.
        (appDel.window?.rootViewController as! SecondPageTBC).setItemNames(DBManager.getTranslationOfSentences(SentencesID: [1 , 9 , 10 , 4]))
        
    }
    
    @IBAction func btnAr(sender: UIButton) {
        outletAr.setBackgroundImage(UIImage(named: "Ar"), forState: .Normal)
        outletEn.setBackgroundImage(UIImage(named: "EnGray"), forState: .Normal)
        outletIr.setBackgroundImage(UIImage(named: "FaGray"), forState: .Normal)
        outletTr.setBackgroundImage(UIImage(named: "TrGray"), forState: .Normal)
        DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.LanguageID, UpdateValue: String(LangID.ARABIC))
        SetLangIDToVar(LangID.ARABIC)
        // Arash : Change tabbar language.
        (appDel.window?.rootViewController as! SecondPageTBC).setItemNames(DBManager.getTranslationOfSentences(SentencesID: [1 , 9 , 10 , 4]))
        
        
    }
    
    @IBAction func btnTr(sender: UIButton) {
        outletTr.setBackgroundImage(UIImage(named: "Tr"), forState: .Normal)
        outletEn.setBackgroundImage(UIImage(named: "EnGray"), forState: .Normal)
        outletAr.setBackgroundImage(UIImage(named: "ArGray"), forState: .Normal)
        outletIr.setBackgroundImage(UIImage(named: "FaGray"), forState: .Normal)
        DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.LanguageID, UpdateValue: String(LangID.TURKISH))
        SetLangIDToVar(LangID.TURKISH)
        // Arash : Change tabbar language.
        (appDel.window?.rootViewController as! SecondPageTBC).setItemNames(DBManager.getTranslationOfSentences(SentencesID: [1 , 9 , 10 , 4]))
        
    }
    
    
    
    
    ///Arash : Run app from the start(LanguageVC).
    private func startAppAgain() {
        let storyBoard = UIStoryboard(name: "Welcome", bundle: nil)
        let languageVC = storyBoard.instantiateViewControllerWithIdentifier("languageVC")
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        
        //        if let app = UIApplication.sharedApplication().delegate as? AppDelegate, let window = app.window {
        //            if let viewControllers = window.rootViewController?.childViewControllers {
        //                for viewController in viewControllers {
        //                    viewController.dismissViewControllerAnimated(false, completion: nil)
        //                }
        //            }
        //        }
        if appDel.socket != nil {
            appDel.socket.close()
            appDel.socket.state = .none
        }
        appDel.network.network.stopNotifier()
        let rootVC = appDel.window?.rootViewController
        rootVC?.view.removeFromSuperview()
        appDel.window!.rootViewController = languageVC
        appDel.window!.makeKeyAndVisible()
        
    }
    
    /// Arash : Set Image Selected Language
    private func setSelectedLangImage() {
        switch SELECTEDLANGID {
        case LangID.ENGLISH :
            outletEn.setBackgroundImage(UIImage(named: "En"), forState: .Normal)
            break
        case LangID.TURKISH :
            outletTr.setBackgroundImage(UIImage(named: "Tr"), forState: .Normal)
            break
        case LangID.PERSIAN :
            outletIr.setBackgroundImage(UIImage(named: "Fa"), forState: .Normal)
            break
        case LangID.ARABIC :
            outletAr.setBackgroundImage(UIImage(named: "Ar"), forState: .Normal)
            break
        default :
            break
        }
    }
    
    ///Arash: Manage topbar for connection status and notify numbers.
    private func manageTopBar() {
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        appDel.actionBarView = topBar
        let notifyCount = DBManager.getAllNotSeenNotifies()
        topBar.messageCount = String(notifyCount!.count)
        switch appDel.actionBarState {
        case ActionBarState.globalConnection :
            appDel.actionBarView.connectionImage = UIImage(named: "icon_main_connection_status_server")
            break
        case ActionBarState.localConnection :
            appDel.actionBarView.connectionImage = UIImage(named: "icon_main_connection_status_local")
            break
        case ActionBarState.noInternetConnection :
            appDel.actionBarView.connectionImage = UIImage(named: "icon_main_connection_status_disconnected")
            break
        default : break
        }
    }
    
    @objc private func updateView(notification : NSNotification) {
        indicator.stopAnimating()
    }
    
}
