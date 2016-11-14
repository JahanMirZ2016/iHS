//
//  SectionRooms.swift
//  iHS Swift
//
//  Created by arash on 11/12/16.
//  Copyright © 2016 Ali Zare Sh. All rights reserved.
//

import UIKit

class SectionRooms: UIView {
    @IBOutlet var view : UIView!
    

    var sectionID = -1
    var context : DevicesVC!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createNib()
    }
    
    
    @IBAction func tappinSelector(sender: UITapGestureRecognizer) {
        Printer(sectionID)
        
    }
    
    func createNib() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "SectionRooms", bundle: bundle)
        
        
        view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth , UIViewAutoresizing.FlexibleHeight]
        
        addSubview(view)
    }
    
    
}
