//
//  DevicesVC.swift
//  iHS Swift
//
//  Created by arash on 11/10/16.
//  Copyright © 2016 Ali Zare Sh. All rights reserved.
//

/*
 Arash : Section2 - Devices View Controller
 */


import UIKit

class DevicesVC: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = CellRooms(frame: CGRectMake(0 , 0 , tableView.frame.width , 80))
        return cell
    }
    
    internal func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 10
    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = SectionRooms(frame: CGRectMake(0 , 0 , tableView.frame.width , 60))
        
        return section
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.clearColor()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "lay_back_welcome")!)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.backgroundColor = UIColor.clearColor()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
