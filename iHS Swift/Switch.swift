//
//  Switch.swift
//  iHS Swift
//
//  Created by arash on 12/4/16.
//  Copyright © 2016 Ali Zare Sh. All rights reserved.
//

import UIKit

@IBDesignable class Switch: UIView {
    
    @IBOutlet var view : UIView!
    var nodeModel:NodeModel?
    var switchModel:SwitchModel? {
        didSet {
            getStateAndRefreshView()
        }
    }
    @IBOutlet weak var labelNodeName: UILabel!
    @IBOutlet weak var labelKey: UILabel!
    @IBOutlet weak var btnSwitch: UIButton!
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
        labelNodeName.text = nodeModel?.name
        addSubview(view)
    }
    
    @IBAction func selectorPols(sender: UIButton) {
        var tag = sender.tag
        var state = DBManager.getNodeValue(tag, nodeID: switchModel!.nodeID)
        if state == 0//Off
        {
            sender.setBackgroundImage(UIImage(named: "SwitchOn"), forState: .Normal)
            state = 1
        }//if
        else
        {
            sender.setBackgroundImage(UIImage(named: "SwitchOff"), forState: .Normal)
            state = 0
        }//else
        //        NSMutableArray *arr=[data getSwitchIDName:node :pol];
        //        [data setSwitchValue:[[[arr objectAtIndex:0] objectForKey:@"ID"]intValue]:state];
        
    }
    
    ///Arash: Selector for favorite.
    @IBAction func selectorFav(sender: UIButton) {
        var fav = DBManager.isBookmark((switchModel?.nodeID)!)
        if fav == 0
        {
            sender.setImage(UIImage(named: "FavoriteOK"), forState: .Normal)
            fav = 1
        }//if
        else
        {
            sender.setImage(UIImage(named: "FavoriteCancel"), forState: .Normal)
            fav = 0
        }//else
        DBManager.updateNodeBookmark((switchModel!.nodeID) , isBookmark : fav)
    }
    
    
    ///Arash: Set and refresh view based on switchmodel state.
    private func getStateAndRefreshView() {
        var state = DBManager.getNodeValue(0, nodeID: switchModel!.nodeID)
        if state == 1 {
            btnSwitch.setBackgroundImage(UIImage(named: "SwitchOn"), forState: .Normal)
        }else {
            btnSwitch.setBackgroundImage(UIImage(named: "SwitchOff"), forState: .Normal)
        }
    }
    
    
}
