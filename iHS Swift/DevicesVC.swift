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
    
    /// reload the tableview.
    var sectionArray = [SectionModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var section1 = SectionModel()
    var sectionArrayy = [SectionModel() , SectionModel() , SectionModel() , SectionModel() , SectionModel()]
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sectionArrayy[section].collapsed ? 5 : 0
    }
    
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = CellRooms(frame: CGRectMake(0 , 0 , tableView.frame.width , 80))
        cell.selectionStyle = .None
        return cell
    }
    
    internal func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionArrayy.count
    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionRooms = SectionRooms(frame: CGRectMake(0 , 0 , tableView.frame.width , 60))
        
        sectionRooms.sectionID = section
        sectionRooms.context = self
        switch sectionArrayy[section].collapsed {
        case true :
            sectionRooms.outletArrow.setImage(UIImage(named: "lay_expandablelist_parrent_arrow_open"), forState: .Normal)
        case false :
            sectionRooms.outletArrow.setImage(UIImage(named: "lay_expandablelist_parrent_arrow_close"), forState: .Normal)
            
        }
        return sectionRooms
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 50
    }
    

    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.clearColor()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "lay_back_welcome")!)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.backgroundColor = UIColor.clearColor()
        
        section1 = SectionModel()
        section1.collapsed = false
        sectionArrayy.append(section1)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
