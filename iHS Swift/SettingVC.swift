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
    
    
    @IBOutlet weak var outletEn: UIButton!
    @IBOutlet weak var outletIr: UIButton!
    @IBOutlet weak var outletAr: UIButton!
    @IBOutlet weak var outletTr: UIButton!
    let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bgMain")!)
        setSelectedLangImage()
        
        // Do any additional setup after loading the view.
    }
    
    /// Arash: Reset all registers and go to LanguageVC.
    @IBAction func btnResetRegister(sender: UIButton) {
        dbUpdate()
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
    
    /// Arash : DB changes.
    private func dbUpdate() {
        DBManager.deleteAllNodes()
        DBManager.deleteAllNotifies()
        DBManager.deleteAllRooms()
        DBManager.deleteAllScenarios()
        DBManager.deleteAllSections()
        DBManager.deleteAllSwitches()
        DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.LanguageID, UpdateValue: "1")
        DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.ServerIP, UpdateValue: "")
        DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.ServerPort, UpdateValue: "")
        DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.CustomerID, UpdateValue: "")
        DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.MobileID, UpdateValue: "")
        DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.WiFiSSID, UpdateValue: "")
        DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.WiFiMac, UpdateValue: "")
        DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.CenterIP, UpdateValue: "")
        DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.CenterPort, UpdateValue: "")
        DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.LastMessageID, UpdateValue: "0")
        DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.ExKey, UpdateValue: "")
        DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.CustomerName, UpdateValue: "")
        DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.Register, UpdateValue: "0")
        DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.Ver, UpdateValue: "1")
    }
    
    
    /// Arash : Run app from the start(LanguageVC).
    private func startAppAgain() {
        let storyBoard = UIStoryboard(name: "Welcome", bundle: nil)
        let languageVC = storyBoard.instantiateViewControllerWithIdentifier("languageVC")
        self.presentViewController(languageVC, animated: true, completion: nil)
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
    
}
