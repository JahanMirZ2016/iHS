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
    
    var sectionArray : [SectionModel]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    var section1 = SectionModel()
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sectionArray![section].collapsed ? 5 : 0
    }
    
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if SELECTEDLANGID == LangID.PERSIAN || SELECTEDLANGID == LangID.ARABIC {
        let cell = CellRooms(frame: CGRectMake(0 , 0 , tableView.frame.width , 80))
        cell.selectionStyle = .None
            cell.labelText = "22"
        return cell
        }
        let cell = CellRoomsLeftAllignment(frame: CGRectMake(0 , 0 , tableView.frame.width , 80))
        cell.selectionStyle = .None
        cell.labelText = "22"
        return cell
    }
    
    
    internal func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionArray!.count
    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if SELECTEDLANGID == LangID.PERSIAN || SELECTEDLANGID == LangID.ARABIC {
            let sectionRooms = SectionRooms(frame: CGRectMake(0 , 0 , tableView.frame.width , 60))
            sectionRoomClick(sectionRooms, viewForHeaderInSection: section)
            return sectionRooms
        }
        
        let sectionRooms = SectionRoomsLeftAllignment(frame: CGRectMake(0 , 0 , tableView.frame.width , 60))
        sectionRoomLeftAllignmentClick(sectionRooms, viewForHeaderInSection: section)
        
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
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bgMain")!)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.backgroundColor = UIColor.clearColor()

        // BinMan1 : Notificatoins comming
        fetchAndRefresh()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.updateView(_:)), name: SECTION_UPDATE_VIEW, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.updateView(_:)), name: ROOM_UPDATE_VIEW, object: nil)
    }
    
    /// Arash : Reloaddata for different view allignments.
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        for section in sectionArray! {
            section.collapsed = false
        }
        // Arash : baad az set kardan e db va araye asli pak shavad.
        tableView.reloadData()
    }
    
    /// Arash : Set sectionroom click .
    func sectionRoomClick(sectionRooms : SectionRooms , viewForHeaderInSection section: Int) {
        sectionRooms.sectionID = section
        sectionRooms.context = self
        switch sectionArray![section].collapsed {
        case true :
            sectionRooms.outletArrow.setImage(UIImage(named: "lay_expandablelist_parrent_arrow_open"), forState: .Normal)
        case false :
            sectionRooms.outletArrow.setImage(UIImage(named: "lay_expandablelist_parrent_arrow_close"), forState: .Normal)
        }
    }
    
    /// Arash : Set sectionroom (left allignment) click .
    func sectionRoomLeftAllignmentClick(sectionRooms : SectionRoomsLeftAllignment , viewForHeaderInSection section: Int) {
        sectionRooms.sectionID = section
        sectionRooms.context = self
        switch sectionArray![section].collapsed {
        case true :
            sectionRooms.outletArrow.setImage(UIImage(named: "lay_expandablelist_parrent_arrow_open"), forState: .Normal)
        case false :
            sectionRooms.outletArrow.setImage(UIImage(named: "lay_expandablelist_parrent_arrow_close"), forState: .Normal)
        }
        
    }
    
    
    /// BinMan1 : Fetch all data and refresh view
    private func fetchAndRefresh() {
        let sections = DBManager.getAllSections()
        
        for section in sections! {
            section.cells = DBManager.getAllRoomsById(SectionID: section.id)!
        }
        
        sectionArray = sections!
    }

    /// BinMan1 : Observer for Sectoins updated 
    @objc private func updateView(notification : NSNotification) {
        fetchAndRefresh()
    }
}
