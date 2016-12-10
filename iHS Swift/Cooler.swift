//
//  Cooler.swift
//  iHS Swift
//
//  Created by arash on 12/4/16.
//  Copyright © 2016 Ali Zare Sh. All rights reserved.
//

/*
 Arash : Cooler Device
 */

import UIKit

@IBDesignable class Cooler: UIView {
    
    @IBOutlet var view : UIView!
    var nodeModel:NodeModel?
    var switchModel:SwitchModel? {
        didSet {
            getStateAndRefreshView()
        }
    }
    
    @IBOutlet weak var btnFav: UIButton!
    @IBOutlet weak var labelNodeName: UILabel!
    @IBOutlet weak var labelWaterPump: UILabel!
    @IBOutlet weak var labelFast: UILabel!
    @IBOutlet weak var labelSlow: UILabel!
    @IBOutlet weak var btnFastCooler: UIButton!
    @IBOutlet weak var btnSlowCooler: UIButton!
    @IBOutlet weak var btnWaterPumpCooler: UIButton!
    
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
        labelSlow.text = (DBManager.getTranslationOfSentences(SentencesID: [27]))[0]
        labelFast.text = (DBManager.getTranslationOfSentences(SentencesID: [26]))[0]
        labelWaterPump.text = (DBManager.getTranslationOfSentences(SentencesID: [28]))[0]
        
        addSubview(view)
        
    }
    
    ///Arash: Selector for 3 buttons(pols)
    @IBAction func selectorPols(sender: UIButton) {
        var tag = sender.tag
        var state = 0.0
        if tag == 2 {
            state = DBManager.getNodeValue(1, nodeID: switchModel!.nodeID)! }
        else {
            state = DBManager.getNodeValue(tag, nodeID: switchModel!.nodeID)! }
        if tag==0
        {
            if state==0 { //Off
                state=1
            }else{
                state=0;
            }//if
        }
        else if tag == 1
        {
            if state==1 {
                state=0;
            }else{
                state=1;
            }//else if
        }
        else if tag == 2
        {
            if state == 2 {
                state=0
            }else{
                state=2;
            }//else
            if tag==2 {
                tag = 1
            }
        }
        var arr = Array<NSDictionary>()
        let dic:NSDictionary = ["ID" : (switchModel?.id)! , "Name" : (switchModel?.name)!]
        arr.append(dic)
        let array = DBManager.getSwitchIDName(switchModel!.nodeID, code: switchModel!.code)
        SendSwitchValue(array![0].id , value: state)
        
        //[data setSwitchValue:[[[arr objectAtIndex:0] objectForKey:@"ID"]intValue]:state];
        //send data to socket
        switchModel?.value = state
        getStateAndRefreshView()
        //        getStateAndRefreshView()
        
        
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
        
        if switchModel?.nodeID != -1 {
            var state = DBManager.getNodeValue(0 , nodeID: (switchModel?.nodeID)!)
            if state == 1 {
                btnWaterPumpCooler.setBackgroundImage(UIImage(named: "CoolerWaterOn") , forState: .Normal)
            } else {
                btnWaterPumpCooler.setBackgroundImage(UIImage(named: "CoolerWaterOff") , forState: .Normal)
            }//else
            
            state = DBManager.getNodeValue(1 , nodeID: (switchModel?.nodeID)!)
            if state == 0 {
                btnSlowCooler.setBackgroundImage(UIImage(named: "CoolerSlowOff"), forState: .Normal)
                btnFastCooler.setBackgroundImage(UIImage(named: "CoolerFastOff"), forState: .Normal)
            }else if state == 1 {
                btnSlowCooler.setBackgroundImage(UIImage(named: "CoolerSlowOn"), forState: .Normal)
                btnFastCooler.setBackgroundImage(UIImage(named: "CoolerFastOff"), forState: .Normal)
            }else if state == 2 {
                btnSlowCooler.setBackgroundImage(UIImage(named: "CoolerSlowOff"), forState: .Normal)
                btnFastCooler.setBackgroundImage(UIImage(named: "CoolerFastOn"), forState: .Normal)
            }
        }
    }
}




