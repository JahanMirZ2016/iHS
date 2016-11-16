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
        if transition.x < -10 {
            let storyBoard = UIStoryboard(name: "Welcome", bundle: nil)
            let registerVC = storyBoard.instantiateViewControllerWithIdentifier("registerVC")
            let transitionStyle = UIModalTransitionStyle.FlipHorizontal
            registerVC.modalTransitionStyle = transitionStyle
            self.presentViewController(registerVC, animated: true, completion: nil)
        } else if transition.x > 10 {
            dismissViewControllerAnimated(true, completion: nil)
        }
        sender.setTranslation(CGPointZero, inView: self.view)
    }
    
}
