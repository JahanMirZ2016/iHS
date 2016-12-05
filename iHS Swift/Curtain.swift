//
//  Curtain.swift
//  iHS Swift
//
//  Created by arash on 12/4/16.
//  Copyright © 2016 Ali Zare Sh. All rights reserved.
//

import UIKit

@IBDesignable class Curtain: UIView {
    
    @IBOutlet var view : UIView!
    var nodeModel:NodeModel?
    var switchModel:SwitchModel? {
        didSet {
            getStateAndRefreshView()
        }
    }
    
    @IBOutlet weak var labelNodeName: UILabel!
    @IBOutlet weak var labelClose: UILabel!
    @IBOutlet weak var labelStop: UILabel!
    @IBOutlet weak var labelOpen: UILabel!
    @IBOutlet weak var btnOpenCurtain: UIButton!
    @IBOutlet weak var btnStopCurtain: UIButton!
    @IBOutlet weak var btnCloseCurtain: UIButton!
    
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
        labelClose.text = (DBManager.getTranslationOfSentences(SentencesID: [25]))[0]
        labelStop.text = (DBManager.getTranslationOfSentences(SentencesID: [24]))[0]
        labelOpen.text = (DBManager.getTranslationOfSentences(SentencesID: [23]))[0]
        labelNodeName.text = nodeModel?.name
        addSubview(view)
    }
    
    
    @IBAction func selectorPols(sender: UIButton) {
        var tag = sender.tag
        var state = DBManager.getNodeValue(0, nodeID: switchModel!.nodeID)
        if state == 0 && tag == 2 {
            return
        }else if state==0 && tag==2
        {
            return
        }//if
        else if state==0 && tag==0
        {
            state=1
        }//else if
        else if state==0 && tag==1
        {
            state=2
        }//else if
        else if state==1 && tag==2
        {
            state=0
        }//if
        else if state==1 && tag==0
        {
            return
        }//else if
        else if state==1 && tag==1
        {
            state=2
        }//else if
        else if state==2 && tag==2
        {
            state=0
        }//if
        else if state==2 && tag==0
        {
            state=1
        }//else if
        else if state==2 && tag==1
        {
            return
        }//else if
        
        var arr = Array<NSDictionary>()
        let dic:NSDictionary = ["ID" : (switchModel?.id)! , "Name" : (switchModel?.name)!]
        arr.append(dic)
        //[data setSwitchValue:[[[arr objectAtIndex:0] objectForKey:@"ID"]intValue]:state];
        //send data to socket
        getStateAndRefreshView()
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
        if switchModel?.nodeID != -1 {
            let state = DBManager.getNodeValue(0 , nodeID: (switchModel?.nodeID)!)
            if state == 0 {
                btnOpenCurtain.setBackgroundImage(UIImage(named: "CurtainOpenOff"), forState: .Normal)
                btnStopCurtain.setBackgroundImage(UIImage(named: "CurtainStopOff"), forState: .Normal)
                btnCloseCurtain.setBackgroundImage(UIImage(named: "CurtainCloseOn"), forState: .Normal)
                
            }else if state == 1 {
                btnOpenCurtain.setBackgroundImage(UIImage(named: "CurtainOpenOn"), forState: .Normal)
                btnStopCurtain.setBackgroundImage(UIImage(named: "CurtainStopOff"), forState: .Normal)
                btnCloseCurtain.setBackgroundImage(UIImage(named: "CurtainCloseOff"), forState: .Normal)
                
            }else if state == 2 {
                btnOpenCurtain.setBackgroundImage(UIImage(named: "CurtainOpenOff"), forState: .Normal)
                btnStopCurtain.setBackgroundImage(UIImage(named: "CurtainStopOn"), forState: .Normal)
                btnCloseCurtain.setBackgroundImage(UIImage(named: "CurtainCloseOff"), forState: .Normal)
            }
        }
    }
    
    
    
    
    
    
}
