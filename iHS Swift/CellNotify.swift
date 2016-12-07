//
//  CellNotify.swift
//  iHS Swift
//
//  Created by arash on 12/7/16.
//  Copyright © 2016 Ali Zare Sh. All rights reserved.
//

import UIKit

class CellNotify: UITableViewCell {
    
    var context: NotifyVC!
    var notifyModel:NotifyModel!
    var row:Int!
    
    @IBOutlet weak var imgBaloon: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelText: UILabel!

    
    var titleText:String {
        get {return labelTitle.text! } set { labelTitle.text = newValue }
    }
    
    var textText:String {
        get { return labelText.text!} set {labelText.text = newValue }
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
        let nib = UINib(nibName: "CellNotification", bundle: bundle)
        view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth , UIViewAutoresizing.FlexibleHeight]
        labelTitle.font = UIFont.boldSystemFontOfSize(15.0)
        imgBaloon.image = UIImage(named: "Baloon")?.stretchableImageWithLeftCapWidth(21, topCapHeight: 14)
        
        addSubview(view)
    }
    
    @IBAction func selectorRemove(sender: UIButton) {
        DBManager.deleteNotify(NotifyID: notifyModel.id)
        context.tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: row, inSection: 0)], withRowAnimation: .Right)
        context.notifyArray = DBManager.getAllNotifies()
        
    }
    
}
