//
//  TopBarRooms.swift
//  iHS Swift
//
//  Created by arash on 12/4/16.
//  Copyright © 2016 Ali Zare Sh. All rights reserved.
//

import UIKit

@IBDesignable class TopBarRooms: UIView {
    
    @IBOutlet var view : UIView!
    
    
    @IBOutlet weak var title: UILabel!
    var context:FavoritesVC?
    
    var setText:String {
        get {
            return title.text!
        }
        set {
            title.text = newValue
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
    
    
    
    func createNib() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "TopBarRooms", bundle: bundle)
        
        
        view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth , UIViewAutoresizing.FlexibleHeight]
        addSubview(view)
    }
    

    @IBAction func selectorBack(sender: UIButton) {
        context?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
}

