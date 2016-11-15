//
//  BarcodeVC.swift
//  iHS Swift
//
//  Created by arash on 11/10/16.
//  Copyright © 2016 Ali Zare Sh. All rights reserved.
//

import UIKit

/*
 Arash : Section1 - Barcode View Controller
 */

class BarcodeVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGestures()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /// Arash : Set gestures.
    func setGestures() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(goToRegisterVC))
        view.addGestureRecognizer(pan)
    }
    
    /// Arash : dismiss BarcodeVC and go to RegisterVC.
     func goToRegisterVC(sender : UIPanGestureRecognizer) {
        let transition = sender.translationInView(self.view)
        if transition.x > 0 {
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    
    
}
