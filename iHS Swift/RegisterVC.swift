//
//  RegisterVC.swift
//  iHS Swift
//
//  Created by arash on 11/10/16.
//  Copyright © 2016 Ali Zare Sh. All rights reserved.
//

/*
 Arash : Section1 - Register View Controller
 */

import UIKit

class RegisterVC: UIViewController {
    
    @IBOutlet weak var edtRegisterName: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGestures()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// Arash : Dismiss keyboard.
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        view.endEditing(true)
    }
    
    /// Arash : Set Edge Gestures
    func setGestures() {
        let leftGestureScreen = UIPanGestureRecognizer(target: self, action: #selector(goToWelcomeVC))
        view.addGestureRecognizer(leftGestureScreen)
        
    }
    
    func goToWelcomeVC(sender : UIPanGestureRecognizer) {
        let transition = sender.translationInView(self.view)
        if transition.x > 0 {
            dismissViewControllerAnimated(true, completion: nil)
        }
    }

    
    
    /// Arash : Register Button
    @IBAction func btnRegister(sender: UIButton) {
        if edtRegisterName.text?.characters.count > 0 {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let barcodeVC = storyBoard.instantiateViewControllerWithIdentifier("barcodeVC") as! BarcodeVC
            let transitionStyle = UIModalTransitionStyle.FlipHorizontal
            barcodeVC.modalTransitionStyle = transitionStyle
            self.presentViewController(barcodeVC, animated: true, completion: nil)
        }else {
            print("Error")
        }
    }
    
    
}
