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
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var regBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGestures()
        setMultipleLangToWidgets()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        edtRegisterName.text = ""
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
    
    /// Arash : Navigate to welcomeVC
    func goToWelcomeVC(sender : UIPanGestureRecognizer) {
        let transition = sender.translationInView(self.view)
        if transition.x > 0 {
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    /// BinMan1 : Set Multiple language to widgets
    private func setMultipleLangToWidgets() {
        let sentences = DBManager.getTranslationOfSentences(SentencesID: [20 , 21])
        regBtn.setTitle(sentences[0], forState: .Normal)
        titleLB.text = sentences[1]
        
        if SELECTEDLANGID == LangID.ARABIC || SELECTEDLANGID == LangID.PERSIAN {
            titleLB.textAlignment = .Right
        } else {
            titleLB.textAlignment = .Left
        }
        
    }
    
    /// Arash : Register Button
    @IBAction func btnRegister(sender: UIButton) {
        if edtRegisterName.text?.characters.count > 0 {
            let storyBoard = UIStoryboard(name: "Welcome", bundle: nil)
            let barcodeVC = storyBoard.instantiateViewControllerWithIdentifier("barcodeVC") as! BarcodeVC
            barcodeVC.registerName = edtRegisterName.text!
            let transitionStyle = UIModalTransitionStyle.FlipHorizontal
            barcodeVC.modalTransitionStyle = transitionStyle
            self.presentViewController(barcodeVC, animated: true, completion: nil)
        }else {
            Printer("Error")
        }
    }
    
    
}
