//
//  Curtain.swift
//  iHS Swift
//
//  Created by arash on 12/4/16.
//  Copyright © 2016 Ali Zare Sh. All rights reserved.
//

import UIKit

@IBDesignable class Curtain: UIView {
    
    @IBOutlet var view : UIView!
    var switchModel:SwitchModel? {
        didSet {
            
        }
    }
    
    @IBOutlet weak var btnOpenCurtain: UIButton!
    @IBOutlet weak var btnStopCurtain: UIButton!
    @IBOutlet weak var btnCloseCurtain: UIButton!
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
    
    @IBAction func selectorOpenCurtain(sender: UIButton) {
    }
    
    @IBAction func selectorStopCurtain(sender: UIButton) {
    }
    
    @IBAction func selectorCloseCurtain(sender: UIButton) {
    }
    
    

    
    
    
    
}
