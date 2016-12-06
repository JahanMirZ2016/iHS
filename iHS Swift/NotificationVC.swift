//
//  NotificationVC.swift
//  iHS Swift
//
//  Created by arash on 12/4/16.
//  Copyright © 2016 Ali Zare Sh. All rights reserved.
//

/*
 Arash: Section2 - Secondary - VC for Notifications.
 */

import UIKit

class NotificationVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var notificationArray:[NotifyModel]?{
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bgMain")!)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.updateView(_:)), name: ACTIONBAR_UPDATE_VIEW, object: nil)
        
    }
    
    @objc private func updateView(notification : NSNotification ) {
        fetchAndRefresh()
    }
    
    private func fetchAndRefresh() {
        notificationArray = DBManager.getAllNotifies()
    }
    
}


///Arash : Extensions for UITablview Delegate and Datasource
extension NotificationVC: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = CellRooms(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
}

///////

extension NotificationVC: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}
