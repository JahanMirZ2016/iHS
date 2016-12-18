//
//  LanguageVC.swift
//  iHS Swift
//
//  Created by arash on 11/10/16.
//  Copyright © 2016 Ali Zare Sh. All rights reserved.
//


/*
 Arash : Section1 - Language View Controller
 */

import UIKit

class LanguageVC: UIViewController {
    
    @IBOutlet weak var outletEn: UIButton!
    @IBOutlet weak var outletIr: UIButton!
    @IBOutlet weak var outletAr: UIButton!
    @IBOutlet weak var outletTr: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGestures()
        setLangID(LangID: SELECTEDLANGID)
        setSelectedLangImage()
        
//        DBManager.getValueOfSettingsDB(Type: TypeOfSettings.CustomerName)
//        
//        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
//        appDel.socket.open(IP: "192.168.1.13", Port: 54128)
//        
//        
//        let verificationModel = VerificationModel()
//        verificationModel.Type = "RequestRegisterMobile"
//        verificationModel.MobileName = "arash"
//        verificationModel.ExKey = "123456789"
//        verificationModel.Serial = "33E096FC-151D-4669-9579-F478BBD4B5C8"
//        DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.CustomerName, UpdateValue: "arash")
//        
//        
//        Printer("Json of VerificationModel \(verificationModel)")
//        
//        let jsonData = JSONSerializer.toJson(verificationModel).stringByAppendingString("\n")
//        Printer("Json of JsonData \(jsonData)")
//        
//        if appDel.socket.send(jsonData) {
//            let vc = UIStoryboard(name: "Main" , bundle: nil).instantiateViewControllerWithIdentifier("SecondPageTBC")
//            let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
//            appDel.window!.rootViewController = vc
//            appDel.window!.makeKeyAndVisible()
//        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /// BinMan1 : Set Image Selected Language
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
    
    
    /// BinMan1 : Set LangID
    private func setLangID(LangID id : Int) {
        SELECTEDLANGID = id
        DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.LanguageID, UpdateValue: "\(id)")
    }
    
    
    /// Set Edge Gestures
    func setGestures() {
        let rightGestureScreen = UIPanGestureRecognizer(target: self, action: #selector(goToWelcomeVC))
        
        view.addGestureRecognizer(rightGestureScreen)
        
    }
    
    ///selector func
    func goToWelcomeVC(sender : UIPanGestureRecognizer) {
        let transition = sender.translationInView(self.view)
        
        if transition.x < 0 {
            let storyBoard = UIStoryboard(name: "Welcome", bundle: nil)
            let welcomeVC = storyBoard.instantiateViewControllerWithIdentifier("welcomeVC")
            let transitionStyle = UIModalTransitionStyle.CoverVertical
            welcomeVC.modalTransitionStyle = transitionStyle
            self.presentViewController(welcomeVC, animated: true, completion: nil)
        }
    }
    
    
    /// Language Buttons
    @IBAction func btnEn(sender: UIButton) {
        print("AA")
        setLangID(LangID: LangID.ENGLISH)
        outletEn.setBackgroundImage(UIImage(named: "En"), forState: .Normal)
        outletAr.setBackgroundImage(UIImage(named: "ArGray"), forState: .Normal)
        outletIr.setBackgroundImage(UIImage(named: "FaGray"), forState: .Normal)
        outletTr.setBackgroundImage(UIImage(named: "TrGray"), forState: .Normal)
        DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.LanguageID, UpdateValue: String(LangID.ENGLISH))
        SetLangIDToVar(LangID.ENGLISH)
        
    }
    
    @IBAction func btnIr(sender: UIButton) {
        setLangID(LangID: LangID.PERSIAN)
        outletIr.setBackgroundImage(UIImage(named: "Fa"), forState: .Normal)
        outletEn.setBackgroundImage(UIImage(named: "EnGray"), forState: .Normal)
        outletAr.setBackgroundImage(UIImage(named: "ArGray"), forState: .Normal)
        outletTr.setBackgroundImage(UIImage(named: "TrGray"), forState: .Normal)
        DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.LanguageID, UpdateValue: String(LangID.PERSIAN))
        SetLangIDToVar(LangID.PERSIAN)
        
        
    }
    
    @IBAction func btnAr(sender: UIButton) {
        setLangID(LangID: LangID.ARABIC)
        outletAr.setBackgroundImage(UIImage(named: "Ar"), forState: .Normal)
        outletEn.setBackgroundImage(UIImage(named: "EnGray"), forState: .Normal)
        outletIr.setBackgroundImage(UIImage(named: "FaGray"), forState: .Normal)
        outletTr.setBackgroundImage(UIImage(named: "TrGray"), forState: .Normal)
        DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.LanguageID, UpdateValue: String(LangID.ARABIC))
        SetLangIDToVar(LangID.ARABIC)
        
    }
    
    @IBAction func btnTr(sender: UIButton) {
        setLangID(LangID: LangID.TURKISH)
        outletTr.setBackgroundImage(UIImage(named: "Tr"), forState: .Normal)
        outletEn.setBackgroundImage(UIImage(named: "EnGray"), forState: .Normal)
        outletAr.setBackgroundImage(UIImage(named: "ArGray"), forState: .Normal)
        outletIr.setBackgroundImage(UIImage(named: "FaGray"), forState: .Normal)
        DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.LanguageID, UpdateValue: String(LangID.TURKISH))
        SetLangIDToVar(LangID.TURKISH)
        
    }
    
    /// Arash : Set default language from database.
    private func setDefaultLanguage() {
        
        switch SELECTEDLANGID {
        case LangID.ENGLISH :
            outletEn.setBackgroundImage(UIImage(named: "En"), forState: .Normal)
        case LangID.ARABIC :
            outletAr.setBackgroundImage(UIImage(named: "Ar"), forState: .Normal)
        case LangID.PERSIAN :
            outletIr.setBackgroundImage(UIImage(named: "Fa"), forState: .Normal)
        case LangID.TURKISH :
            outletTr.setBackgroundImage(UIImage(named: "Tr"), forState: .Normal)
        default: break
            
        }
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    
}
