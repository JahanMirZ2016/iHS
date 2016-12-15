//
//  CellRoomsLeftAllignment.swift
//  iHS Swift
//
//  Created by arash on 11/16/16.
//  Copyright © 2016 Ali Zare Sh. All rights reserved.
//

import UIKit

class CellRoomsLeftAllignment: UITableViewCell {
    
    var context:DevicesVC!
    var indexPath:NSIndexPath!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var viewMiddle: UIView!
    
    var labelText:String {
        get {
            return label.text!
        }
        
        set {
            label.text = newValue
        }
    }
    
    var imgImage:UIImage {
        get {
            return img.image!
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
        let nib = UINib(nibName: "CellRoomsLeftAllignment", bundle: bundle)
        
        view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth , UIViewAutoresizing.FlexibleHeight]
        viewMiddle.layer.cornerRadius = 15
        
        addSubview(view)
    }
    
    @IBAction func gestureSegue(sender: UITapGestureRecognizer) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let vc = story.instantiateViewControllerWithIdentifier("favoritesVC") as! FavoritesVC
        vc.type = .rooms
        vc.roomModel = context.sectionArray![indexPath.section].cells[indexPath.row]
        vc.topBarBackTitle = "\(context.sectionArray![indexPath.section].name) / \(context.sectionArray![indexPath.section].cells[indexPath.row].name)"
        context.presentViewController(vc, animated: true, completion: nil)
    }
}
