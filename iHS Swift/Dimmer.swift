//
//  Dimmer.swift
//  iHS Swift
//
//  Created by arash on 12/4/16.
//  Copyright © 2016 Ali Zare Sh. All rights reserved.
//

import UIKit

/*
 Arash : Dimmer Device
 */

class Dimmer: UIView {
    
    @IBOutlet weak var btnFav: UIButton!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var labelNodeName: UILabel!
    @IBOutlet weak var labelValue: UILabel!
    var nodeModel:NodeModel?
    var switchModel:SwitchModel? {
        didSet {
            getStateAndRefreshView()
        }
    }
    @IBOutlet var view : UIView!
    
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
        let nib = UINib(nibName: "Dimmer", bundle: bundle)
        view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth , UIViewAutoresizing.FlexibleHeight]
        
        slider.minimumValue = 0
        slider.maximumValue = 100
        //the slider triggers the associated action method just once, when the user releases the slider.
        slider.continuous = false
        let trans = CGAffineTransformMakeRotation(CGFloat(M_PI) * 1.5)
        let imgMax = UIImage(named: "DimmmerOff")?.resizableImageWithCapInsets(UIEdgeInsetsMake(0, 0, 0, 0))
        let imgMin = UIImage(named: "DimmmerOn")?.resizableImageWithCapInsets(UIEdgeInsetsMake(0, 0, 0, 0))
        slider.value = 0
        slider.transform = trans
        
        slider.setMaximumTrackImage(imgMax, forState: .Normal)
        slider.setMinimumTrackImage(imgMin, forState: .Normal)
        slider.setThumbImage(UIImage(), forState: .Normal)
        slider.setValue(Float(0), animated: true)

        
        addSubview(view)
    }
    
    @IBAction func selectorFav(sender: UIButton) {
        var fav = DBManager.isBookmark((switchModel?.nodeID)!)
        if fav == 0
        {
            sender.setImage(UIImage(named: "FavoriteOK"), forState: .Normal)
            fav = 1
        }
        else
        {
            sender.setImage(UIImage(named: "FavoriteCancel"), forState: .Normal)
            fav = 0
        }
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
        
        let val = DBManager.getNodeValue(0, nodeID: switchModel!.nodeID)
        
        slider.setValue(Float(val!), animated: true)
        labelValue.text = "\(Int(val!))%"
        slider.addTarget(self, action: #selector(sliderValueChanged), forControlEvents: .ValueChanged )
        
        
    }
    
    @objc private func sliderValueChanged() {
        let val = Int(slider.value)
        labelValue.text = "\(val)%"
        let array = DBManager.getSwitchIDName(switchModel!.nodeID, code: slider.tag)
        Printer(val)
        SendSwitchValue(array![0].id , value: Double(val))
        switchModel?.value = Double(val)

    }
    
}



