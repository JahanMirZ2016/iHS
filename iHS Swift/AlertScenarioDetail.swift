//
//  AlertScenarioDetail.swift
//  iHS Swift
//
//  Created by arash on 12/8/16.
//  Copyright © 2016 Ali Zare Sh. All rights reserved.
//

import UIKit

class AlertScenarioDetail: UIView {
    
    @IBOutlet var view : UIView!
    var context:ScenarioDetailVC?
    
    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var btnOK: UIButton!
    
    var setText:String {
        get {return labelMessage.text! }
        set {labelMessage.text = newValue }
    }
    
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
        let nib = UINib(nibName: "AlertScenarioDetail", bundle: bundle)
        
        
        view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth , UIViewAutoresizing.FlexibleHeight]
        addSubview(view)
    }
    
    @IBAction func selectorOK(sender: UIButton) {
        context?.hideAlert()
    }
    
    @IBAction func gestureHide(sender: UITapGestureRecognizer) {
        context!.hideAlert()
    }
}
