//
//  CellScenario.swift
//  iHS Swift
//
//  Created by arash on 11/15/16.
//  Copyright © 2016 Ali Zare Sh. All rights reserved.
//

/*
 Arash : Cell for scenario viewcontroller.(tableview)
 */

import UIKit

class CellScenarios: UITableViewCell {
    
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    var textName:String? {
        get {
            return labelName.text
        }
        set {
            labelName.text = newValue
        }
    }
    
    var textDescription:String? {
        get {
            return labelDescription.text
        }
        set {
            labelDescription.text = newValue
        }
    }
    
    var setImage:UIImage? {
        get {
            return nil
        }
        set {
            img.image = newValue
        }
   
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createNib()
    }
    
    @IBOutlet var view : UIView!
    
    func createNib() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "CellScenarios", bundle: bundle)
        
        
        view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth , UIViewAutoresizing.FlexibleHeight]
        
        addSubview(view)
    }


}
