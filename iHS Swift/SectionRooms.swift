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
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var imgSection: UIImageView!
    @IBOutlet weak var outletArrow: UIButton!


    var sectionID = -1
    var context : DevicesVC!
    
    
    
    var setImage:UIImage? {
        get {
            return nil
        }
        set {
            imgSection.image = newValue
        }
    }
    
    var text:String? {
        get {
            return labelName.text
        } set {
            labelName.text = newValue
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
    @IBAction func tappinSelector(sender: UITapGestureRecognizer) {
        context.tableView.beginUpdates()
        context.sectionArrayy[sectionID].collapsed = !context.sectionArrayy[sectionID].collapsed
        context.tableView.reloadSections(NSIndexSet(index: sectionID), withRowAnimation: .Fade)
        context.tableView.endUpdates()
        
  
    }
    
    func createNib() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "SectionRooms", bundle: bundle)
        
        
        view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth , UIViewAutoresizing.FlexibleHeight]
        labelName.font = UIFont.boldSystemFontOfSize(10.0)
        addSubview(view)
    }
    
    
}
