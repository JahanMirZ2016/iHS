//
//  TopBar.swift
//  iHS Swift
//
//  Created by arash on 11/9/16.
//  Copyright © 2016 Ali Zare Sh. All rights reserved.
//

import UIKit

@IBDesignable class TopBar: UIView {
    
    
    @IBOutlet weak var imgConnection: UIImageView!
    
    @IBOutlet weak var labelMessage: UILabel!
    
    /// Set Image for different kind of connections. (UIImage)
    var connectionImage:UIImage! {
        set {
            imgConnection.image = newValue
        }
        get {
            return nil
        }
    }
    
    
    /// Set number of Messages. (Notifications) (String)
    @IBInspectable var messageCount:String {
        set {
            labelMessage.text = newValue
        }
        get {
            return labelMessage.text!
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
    
    
    @IBOutlet var view : UIView!
    
    
    
    func createNib() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "TopBar", bundle: bundle)
        
        
        view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth , UIViewAutoresizing.FlexibleHeight]
        
        addSubview(view)
    }
    
    
}
