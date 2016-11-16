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
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            let transitionStyle = UIModalTransitionStyle.FlipHorizontal
            welcomeVC.modalTransitionStyle = transitionStyle
            self.presentViewController(welcomeVC, animated: true, completion: nil)
        }
    }
    
    
    
    
    /// Language Buttons
    @IBAction func btnEn(sender: UIButton) {
        print("AA")
        outletEn.setBackgroundImage(UIImage(named: "En"), forState: .Normal)
        outletAr.setBackgroundImage(UIImage(named: "ArGray"), forState: .Normal)
        outletIr.setBackgroundImage(UIImage(named: "FaGray"), forState: .Normal)
        outletTr.setBackgroundImage(UIImage(named: "TrGray"), forState: .Normal)
        
        
    }
    
    @IBAction func btnIr(sender: UIButton) {
        outletIr.setBackgroundImage(UIImage(named: "Fa"), forState: .Normal)
        outletEn.setBackgroundImage(UIImage(named: "EnGray"), forState: .Normal)
        outletAr.setBackgroundImage(UIImage(named: "ArGray"), forState: .Normal)
        outletTr.setBackgroundImage(UIImage(named: "TrGray"), forState: .Normal)
        
        
        
    }
    
    @IBAction func btnAr(sender: UIButton) {
        outletAr.setBackgroundImage(UIImage(named: "Ar"), forState: .Normal)
        outletEn.setBackgroundImage(UIImage(named: "EnGray"), forState: .Normal)
        outletIr.setBackgroundImage(UIImage(named: "FaGray"), forState: .Normal)
        outletTr.setBackgroundImage(UIImage(named: "TrGray"), forState: .Normal)
        
    }
    
    @IBAction func btnTr(sender: UIButton) {
        outletTr.setBackgroundImage(UIImage(named: "Tr"), forState: .Normal)
        outletEn.setBackgroundImage(UIImage(named: "EnGray"), forState: .Normal)
        outletAr.setBackgroundImage(UIImage(named: "ArGray"), forState: .Normal)
        outletIr.setBackgroundImage(UIImage(named: "FaGray"), forState: .Normal)
        
        
    }
    
    
    
    
    
}
