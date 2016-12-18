//
//  WelcomeVC.swift
//  iHS Swift
//
//  Created by arash on 11/10/16.
//  Copyright © 2016 Ali Zare Sh. All rights reserved.
//

/*
 Arash : Section1 - Welcome View Controller
 */

import UIKit

class WelcomeVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGestures()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    /// Set Edge Gestures
    func setGestures() {
        let gestureScreen = UIPanGestureRecognizer(target: self, action: #selector(goToVC))
        
        view.addGestureRecognizer(gestureScreen)
    }
    
    ///selector func
    func goToVC(sender : UIPanGestureRecognizer) {
        let transition = sender.translationInView(self.view)
        print(transition.x)
        if transition.x < -5 {
            let storyBoard = UIStoryboard(name: "Welcome", bundle: nil)
            let registerVC = storyBoard.instantiateViewControllerWithIdentifier("registerVC")
//            let transitionStyle = UIModalTransitionStyle.FlipHorizontal
            let transitionStyle = UIModalTransitionStyle.CrossDissolve

            registerVC.modalTransitionStyle = transitionStyle
            self.presentViewController(registerVC, animated: true, completion: nil)
        } else if transition.x > 10 {
            dismissViewControllerAnimated(true, completion: nil)
        }
        sender.setTranslation(CGPointZero, inView: self.view)
    }
    

//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//        DBManager.getValueOfSettingsDB(Type: TypeOfSettings.CustomerName)
//        
//        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
//        appDel.socket.open(IP: "192.168.1.13", Port: 54128)
//        
//        
//        let verificationModel = VerificationModel()
//        verificationModel.Type = "RequestRegisterMobile"
//        verificationModel.MobileName = "dfdfdfd"
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
//
//    }
    ///Arash: Change statusbar style(light content color)
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

}
