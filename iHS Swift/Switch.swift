//
//  Switch.swift
//  iHS Swift
//
//  Created by arash on 12/4/16.
//  Copyright © 2016 Ali Zare Sh. All rights reserved.
//

/*
 Arash : Switch Device
 */

import UIKit

@IBDesignable class Switch: UIView {
    
    @IBOutlet weak var btnFav: UIButton!
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
        let nib = UINib(nibName: "Switch", bundle: bundle)
        view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth , UIViewAutoresizing.FlexibleHeight]
        addSubview(view)
    }
    
    @IBAction func selectorPols(sender: UIButton) {
        let tag = sender.tag
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
        let array = DBManager.getSwitchIDName(switchModel!.nodeID, code: switchModel!.code)
        SendSwitchValue(array![0].id , value: state!)
        
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
    
    
    ///Arash: Set and refresh view based on switchmodel and its state.
    private func getStateAndRefreshView() {
        labelNodeName.text = nodeModel?.name

        let fav = DBManager.isBookmark((switchModel?.nodeID)!)
        if fav == 0
        {
            btnFav.setImage(UIImage(named: "FavoriteCancel"), forState: .Normal)
        }
        else
        {
            btnFav.setImage(UIImage(named: "FavoriteOK"), forState: .Normal)
        }
        let state = DBManager.getNodeValue(0, nodeID: switchModel!.nodeID)
        if state == 1 {
            btnSwitch.setBackgroundImage(UIImage(named: "SwitchOn"), forState: .Normal)
        }else {
            btnSwitch.setBackgroundImage(UIImage(named: "SwitchOff"), forState: .Normal)
        }
    }
    
    
}
