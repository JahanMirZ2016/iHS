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
    
}
