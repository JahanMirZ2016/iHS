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
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "lay_back_welcome")!)

        // Do any additional setup after loading the view.
    }

    
    /// Language Buttons
    @IBAction func btnEn(sender: UIButton) {
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
