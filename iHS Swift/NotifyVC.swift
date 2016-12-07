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
    
    var notifyArray:[NotifyModel]?{
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
        notifyArray = DBManager.getAllNotifies()
    }
    
}


///Arash : Extensions for UITablview Delegate and Datasource
extension NotifyVC: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = CellNotify(frame: CGRect(x: 0, y: 0, width: WIDTHPHONE, height: 120))
        cell.textText = notifyArray![indexPath.row].notifyText
        cell.titleText = notifyArray![indexPath.row].notifyTitle
        cell.context = self
        cell.notifyModel = notifyArray![indexPath.row]
        cell.row = indexPath.row
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
}

///////

extension NotifyVC: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}
