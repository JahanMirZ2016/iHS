//
//  Dimmer.swift
//  iHS Swift
//
//  Created by arash on 12/4/16.
//  Copyright © 2016 Ali Zare Sh. All rights reserved.
//

import UIKit

class Dimmer: UIView {
    
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
        let nib = UINib(nibName: "Cooler", bundle: bundle)
        view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth , UIViewAutoresizing.FlexibleHeight]
        labelNodeName.text = nodeModel?.name
        addSubview(view)
    }
    
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
    private func getStateAndRefreshView() {
        let val = DBManager.getNodeValue(0, nodeID: switchModel!.nodeID)
        slider.minimumValue = 0
        slider.maximumValue = 0
        let trans = CGAffineTransformMakeRotation(CGFloat(M_PI) * 1.5)
        let imgMax = UIImage(named: "DimmmerOn")?.resizableImageWithCapInsets(UIEdgeInsetsMake(0, 0, 0, 0))
        let imgMin = UIImage(named: "DimmerOff")?.resizableImageWithCapInsets(UIEdgeInsetsMake(0, 0, 0, 0))
        slider.setMaximumTrackImage(imgMax, forState: .Normal)
        slider.setMinimumTrackImage(imgMin, forState: .Normal)
        slider.setThumbImage(UIImage(), forState: .Normal)
        slider.setValue(Float(val!), animated: true)
        slider.addTarget(self, action: #selector(sliderValueChanged), forControlEvents: .ValueChanged)

    }
    
    @objc private func sliderValueChanged() {
        let val = slider.value
        labelValue.text = "\(val)%"
//        NSMutableArray *arr=[data getSwitchIDName:node :(int)slider1.tag];
//        [data setSwitchValue:[[[arr objectAtIndex:0] objectForKey:@"ID"]intValue]:val];
    }
    
}



//labelNodeName.text = nodeModel?.name
