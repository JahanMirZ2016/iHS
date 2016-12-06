//
//  DeviceVC.swift
//  iHS Swift
//
//  Created by arash on 12/4/16.
//  Copyright © 2016 Ali Zare Sh. All rights reserved.
//

/*
 Arash: Section2 - Secondary - Device View Controller.(For showing each device switches.)
 */

import UIKit

class DeviceVC: UIViewController {
    
    var switchModel:SwitchModel? {
        didSet {
            setSwitchType(switchType)
        }
    }
    var nodeModel:NodeModel!
    var nodeType:Int!
    var switchView:UIView!
    var switchType = SwitchType.none
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bgMain")!)
        nodeType = nodeModel.nodeType
        createView(switchModel!)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(updateView), name: SWITCH_UPDATE_VIEW , object: nil)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        fetchAndRefresh()
    }
    
    ///Arash: Create View based on nodeType.
    private func createView(switchModel: SwitchModel) {
        
        //Pol
        if nodeType == 1 || nodeType==2 || nodeType==3 {
            
            let view = Switch(frame: CGRect(x: WIDTHPHONE/4 , y: HEIGHTPHONE/4 , width: WIDTHPHONE/2 , height: HEIGHTPHONE/2 ))
            view.switchModel = switchModel
            switchType = .switchh
            self.view.addSubview(view)
            
            //Dimmer
        }else if nodeType==4 || nodeType==5 {
            let view = Dimmer(frame: CGRect(x: WIDTHPHONE/4 , y: HEIGHTPHONE/4 , width: WIDTHPHONE/2 , height: HEIGHTPHONE/2 ))
            view.switchModel = switchModel
            switchType = .dimmer
            self.view.addSubview(view)
            
            //Cooler
        }else if nodeType==6  {
            let view = Cooler(frame: CGRect(x: WIDTHPHONE/4 , y: HEIGHTPHONE/4 , width: WIDTHPHONE/2 , height: HEIGHTPHONE/2 ))
            view.switchModel = switchModel
            switchType = .cooler
            self.view.addSubview(view)
            
            
            //Curtain
        }else if nodeType==7 {
            let view = Curtain(frame: CGRect(x: WIDTHPHONE/4 , y: HEIGHTPHONE/4 , width: WIDTHPHONE/2 , height: HEIGHTPHONE/2 ))
            view.switchModel = switchModel
            switchType = .curtain
            self.view.addSubview(view)
            
        }
    }
    
    ///Arash: Update view for every notification and update data and ui.
    @objc private func updateView() {
        fetchAndRefresh()
    }
    
    ///Arash: Fetch data and refresh view.
    private func fetchAndRefresh() {
        switchModel = DBManager.getSwitch(SwitchID: nodeModel.id)
    }
    
    
    ///Arash: Set switch type and refresh views based on data gathered from database.
    private func setSwitchType(switchType : SwitchType) {
        switch switchType {
        case .cooler : (switchView as! Cooler).switchModel = switchModel
        (switchView as! Cooler).nodeModel = nodeModel
            break
        case .curtain : (switchView as! Curtain).switchModel = switchModel
        (switchView as! Cooler).nodeModel = nodeModel
            break
        case .dimmer : (switchView as! Dimmer).switchModel = switchModel
        (switchView as! Cooler).nodeModel = nodeModel
            break
        case .switchh : (switchView as! Switch).switchModel = switchModel
        (switchView as! Cooler).nodeModel = nodeModel
            break
        default : break
        }
    }
    
    
}
