//
//  TopBarScenario.swift
//  iHS Swift
//
//  Created by arash on 11/21/16.
//  Copyright © 2016 Ali Zare Sh. All rights reserved.
//

import UIKit

@IBDesignable class TopBarScenario: UIView {
    
    @IBOutlet var view : UIView!
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnRun: UIButton!
    @IBOutlet weak var btnOnOff: UIButton!
    
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
            btnRun.setImage(newValue, forState: .Normal)
        }
    }
    
    var btnOnOffImage:UIImage? {
        get {
            return nil
        }
        set {
            btnOnOff.setImage(newValue, forState: .Normal)
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
    
    @IBAction func selectorOnOff(sender: UIButton) {
    }
    
    @IBAction func selectorRun(sender: UIButton) {
    }
    @IBAction func selectorBack(sender: UIButton) {
        context?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
}
