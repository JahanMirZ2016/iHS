//
//  NotifyVC.swift
//  iHS Swift
//
//  Created by arash on 12/7/16.
//  Copyright © 2016 Ali Zare Sh. All rights reserved.
//

import UIKit

class NotifyVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var topBar: TopBar!
    var notifyArray:[NotifyModel]?{
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bgMain")!)
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.clearColor()

        
        
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        manageTopBar()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.updateView(_:)), name: ACTIONBAR_UPDATE_VIEW, object: nil)
        
    }
    
    ///Arash: updateView for new data.
    @objc private func updateView(notification : NSNotification ) {
        fetchAndRefresh()
    }
    ///Arash: Fetch data from DB and refresh view (with didSet)
    private func fetchAndRefresh() {
        notifyArray = DBManager.getAllNotifies()
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


///Arash : Extensions for UITablview Delegate and Datasource
extension NotifyVC: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = CellNotify(frame: CGRect(x: 0, y: 0, width: WIDTHPHONE, height: 120))
//        cell.textText = notifyArray![indexPath.row].notifyText
//        cell.titleText = notifyArray![indexPath.row].notifyTitle
//        cell.context = self
//        cell.notifyModel = notifyArray![indexPath.row]
//        cell.row = indexPath.row
        cell.backgroundColor = UIColor.clearColor()
        cell.selectionStyle = .None
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    

    
}

///////

extension NotifyVC: UITableViewDelegate {
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    

}
