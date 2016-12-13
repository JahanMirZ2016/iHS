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
    var notifyArray:[NotifyModel]? = [NotifyModel](){
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Load last 10 notifies and mark them as seen.
        loadNotifies()
        
        topBar.btnNotify.hidden = true
        topBar.labelMessage.hidden = true
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bgMain")!)
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.clearColor()
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        //        tableView.setNeedsLayout()
        //        tableView.layoutIfNeeded()
        tableView.reloadData()
        
        
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        manageTopBar()
        NSNotificationCenter.defaultCenter().postNotificationName(ACTIONBAR_UPDATE_VIEW, object: ActionBarState.notify as AnyObject)
        //        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.updateView(_:)), name: ACTIONBAR_UPDATE_VIEW, object: nil)
        
    }
    
    ///Arash: updateView for new data.
    @objc private func updateView(notification : NSNotification ) {
        fetchAndRefresh()
    }
    ///Arash: Fetch data from DB and refresh view (with didSet)
    private func fetchAndRefresh() {
        notifyArray = DBManager.getLastNotifies()
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
    
    ///Arash: Load last 10 notifies stored in database.
    private func loadNotifies() {
        notifyArray = DBManager.getLastNotifies()
//        DBManager.updateLastNotifies()
    }
    
    @IBAction func selectorBack(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}


///Arash : Extensions for UITablview Delegate and Datasource
extension NotifyVC: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (notifyArray?.count)!
        //        return (DBManager.getLastNotifies()?.count)!
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = CellNotify(frame: CGRect(x: 0, y: 0, width: WIDTHPHONE, height: 0))
        cell.textText = notifyArray![indexPath.row].notifyText
        cell.titleText = notifyArray![indexPath.row].notifyTitle
        cell.context = self
        cell.notifyModel = notifyArray![indexPath.row]
        cell.row = indexPath.row
        
        
        cell.layoutIfNeeded()
        cell.backgroundColor = UIColor.clearColor()
        cell.selectionStyle = .None
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    //
    //        return 200
    //    }
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
}

///////

extension NotifyVC: UITableViewDelegate {
    
    ///Arash: Tableview swipe action button.
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .Normal, title: "    ") { (action, indexPath) in
            
            
            DBManager.deleteNotify(self.notifyArray![indexPath.row].notifyText, notifyTitle: self.notifyArray![indexPath.row].notifyTitle)
            //            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Right)
            
            self.notifyArray?.removeAtIndex(indexPath.row)
            self.loadNotifies()
            
            
        }
        
        let img: UIImage = UIImage(named: "garbage")!
        let imgSize: CGSize = tableView.frame.size
        UIGraphicsBeginImageContext(imgSize)
        img.drawInRect(CGRectMake(15, 25, 20, 20))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        delete.backgroundColor = UIColor(patternImage: newImage)
        return [delete]
    }
    
    
}
