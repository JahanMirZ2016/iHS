//
//  Cooler.swift
//  iHS Swift
//
//  Created by arash on 12/4/16.
//  Copyright © 2016 Ali Zare Sh. All rights reserved.
//

import UIKit

@IBDesignable class Cooler: UIView {
    
    @IBOutlet var view : UIView!
    var switchModel:SwitchModel? {
        didSet {
            getStateAndRefreshView()
        }
    }
    @IBOutlet weak var btnFastCooler: UIButton!
    @IBOutlet weak var btnSlowCooler: UIButton!
    @IBOutlet weak var btnWaterPumpCooler: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createNib()
    }
    
    
    func createNib() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "Cooler", bundle: bundle)
        
        
        view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth , UIViewAutoresizing.FlexibleHeight]
        addSubview(view)
        
    }
    
    @IBAction func selectorFast(sender: UIButton) {
        
    }
    
    @IBAction func selectorSlow(sender: UIButton) {
    }
    
    @IBAction func selectorWaterPump(sender: UIButton) {
    }
    
    ///Arash: Set and refresh view based on switchmodel
    private func getStateAndRefreshView() {
        var state = DBManager.getNodeValue(0 , nodeID: (switchModel?.nodeID)!)
        if state == 1 {
            btnWaterPumpCooler.setBackgroundImage(UIImage(named: "CoolerWaterOn") , forState: .Normal)
        } else {
            btnWaterPumpCooler.setBackgroundImage(UIImage(named: "CoolerWaterOff") , forState: .Normal)
        }//else 
        
        state = DBManager.getNodeValue(1 , nodeID: (switchModel?.nodeID)!)
        if state == 0 {
            btnSlowCooler.setBackgroundImage(UIImage(named: "CoolerSlowOff"), forState: .Normal)
            btnFastCooler.setBackgroundImage(UIImage(named: "CoolerFastOff"), forState: .Normal)
        }else if state == 1 {
            btnSlowCooler.setBackgroundImage(UIImage(named: "CoolerSlowOn"), forState: .Normal)
            btnFastCooler.setBackgroundImage(UIImage(named: "CoolerFastOff"), forState: .Normal)
        }else if state == 2 {
            btnSlowCooler.setBackgroundImage(UIImage(named: "CoolerSlowOff"), forState: .Normal)
            btnFastCooler.setBackgroundImage(UIImage(named: "CoolerFastOn"), forState: .Normal)
        }
    }
    

    
}
