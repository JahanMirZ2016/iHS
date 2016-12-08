//
//  TopBarScenario.swift
//  iHS Swift
//
//  Created by arash on 11/21/16.
//  Copyright © 2016 Ali Zare Sh. All rights reserved.
//

import UIKit

@IBDesignable class TopBarScenario: UIView {
    
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnActive: UIButton!
    @IBOutlet var view : UIView!
    var scenarioModel:ScenarioModel! {
        didSet {
            updateTopBar()
        }
    }
    @IBOutlet weak var btnBack: UIButton!
    
    
    var context:ScenarioDetailVC?
    
    var btnBackImage:UIImage? {
        get {
            return nil
        }
        set {
            btnBack.setImage(newValue, forState: .Normal)
        }
    }
    
    var btnRunImage:UIImage? {
        get {
            return nil
        }
        set {
            btnStart.setImage(newValue, forState: .Normal)
        }
    }
    
    var btnOnOffImage:UIImage? {
        get {
            return nil
        }
        set {
            btnActive.setImage(newValue, forState: .Normal)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createNib()
    }
    
    
    /// Arash : tap gesture recognizer for each tableview header.
    
    
    func createNib() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "TopBarScenario", bundle: bundle)
        
        
        view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth , UIViewAutoresizing.FlexibleHeight]
        addSubview(view)
    }
    
    private func updateTopBar() {
        if scenarioModel.active == 1 {
            btnActive.setBackgroundImage(UIImage(named : "BtnScenarioA"), forState: .Normal )
        } else {
            btnActive.setBackgroundImage(UIImage(named: "BtnScenarioD"), forState: .Normal)
        }
        if scenarioModel.isStarted == 0 {
            btnStart.setBackgroundImage(UIImage(named: "ScenarioOff"), forState: .Normal)
        } else {
            btnStart.hidden = true
        }
    }
    
    @IBAction func selectorBack(sender: UIButton) {
        context?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func selectorStart(sender: UIButton) {
        if scenarioModel.isStarted == 0 {
            if SetScenarioStarted(scenarioModel) {
                scenarioModel.isStarted = 1
                btnStart.hidden = true
            }
        }
    }
    
    
    
    @IBAction func selectorActive(sender: UIButton) {
        if scenarioModel.active == 0 {
            scenarioModel.active = 1
            btnActive.setBackgroundImage(UIImage(named : "BtnScenarioA"), forState: .Normal)
        } else if scenarioModel.active == 1 {
            scenarioModel.active = 0
            btnActive.setBackgroundImage(UIImage(named : "BtnScenarioD"), forState: .Normal)
            //            context!.showAlert()
        } else if scenarioModel.active == -1 {
            context!.showAlert()
        }
        SetScenarioActive(scenarioModel)
    }
    
    
    
    
}
