//
//  CellFavorites.swift
//  iHS Swift
//
//  Created by arash on 11/15/16.
//  Copyright © 2016 Ali Zare Sh. All rights reserved.
//

/*
 Arash : Cell for favorites viewcontroller.(collectionview)
 */

import UIKit


 class CellFavorites: UICollectionViewCell {
    
    @IBOutlet weak var imgCell: UIImageView!
    @IBOutlet weak var labelCell: UILabel!
    
    var image:String? {
        set {
            imgCell.image = UIImage(named: newValue!)
        }
        get {
            return nil
        }
    }
    
    var text:String? {
        get {
          return labelCell.text
        }
        set {
            labelCell.text = newValue
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
        let nib = UINib(nibName: "CellFavorites", bundle: bundle)
        view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth , UIViewAutoresizing.FlexibleHeight]
        addSubview(view)
    }
    
}
