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
    
    @IBOutlet weak var topBar: TopBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topBar.viewController = self
        fetchAndRefresh()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bgMain")!)
        nodeType = nodeModel.nodeType
        createView(switchModel!)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(updateView), name: SWITCH_UPDATE_VIEW , object: nil)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        fetchAndRefresh()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        manageTopBar()
    }
    
    ///Arash: Create View based on nodeType.
    private func createView(switchModel: SwitchModel) {
        
        //Pol
        if nodeType == 1 || nodeType==2 || nodeType==3 {
            
            let view = Switch(frame: CGRect(x: 50 , y: 100 , width: WIDTHPHONE - 100 , height: HEIGHTPHONE - 150 ))
            view.switchModel = switchModel
            view.nodeModel = nodeModel
            switchType = .switchh
            switchView = view
            self.view.addSubview(switchView)
            
            //Dimmer
        }else if nodeType==4 || nodeType==5 {
            let view = Dimmer(frame: CGRect(x: 50 , y: 100 , width: WIDTHPHONE - 100 , height: HEIGHTPHONE - 150 ))
            switchView = view
            view.nodeModel = nodeModel
            view.switchModel = switchModel
            switchType = .dimmer
            self.view.addSubview(view)
            
            //Cooler
        }else if nodeType==6  {
            let view = Cooler(frame: CGRect(x: 50 , y: 100 , width: WIDTHPHONE - 100 , height: HEIGHTPHONE - 150 ))
            view.switchModel = switchModel
            view.nodeModel = nodeModel
            switchType = .cooler
            switchView = view
            self.view.addSubview(view)
            
            
            //Curtain
        }else if nodeType==7 {
            let view = Curtain(frame: CGRect(x: 50 , y: 100 , width: WIDTHPHONE - 100 , height: HEIGHTPHONE - 150 ))
            switchView = view
            view.nodeModel = nodeModel
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
        case .cooler :
            (switchView as! Cooler).nodeModel = nodeModel
            (switchView as! Cooler).switchModel = switchModel
            break
        case .curtain :
            (switchView as! Curtain).nodeModel = nodeModel
            (switchView as! Curtain).switchModel = switchModel
            break
        case .dimmer :
            (switchView as! Dimmer).nodeModel = nodeModel
            (switchView as! Dimmer).switchModel = switchModel
            break
        case .switchh :
            (switchView as! Switch).nodeModel = nodeModel
            (switchView as! Switch).switchModel = switchModel
            break
        default : break
        }
    }
    
    ///Arash: Manage topbar for connection status and notify numbers.
    private func manageTopBar() {
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        appDel.actionBarView = topBar
        let notifyCount = DBManager.getAllNotSeenNotifies()
        topBar.messageCount = String(notifyCount!.count)
        switch appDel.actionBarState {
        case ActionBarState.globalConnection :
            appDel.actionBarView.connectionImage = UIImage(named: "icon_main_connection_status_server")
            break
        case ActionBarState.localConnection :
            appDel.actionBarView.connectionImage = UIImage(named: "icon_main_connection_status_local")
            break
        case ActionBarState.noInternetConnection :
            appDel.actionBarView.connectionImage = UIImage(named: "icon_main_connection_status_disconnected")
            break
        default : break
        }
    }
    
    
    @IBAction func selectorBack(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
