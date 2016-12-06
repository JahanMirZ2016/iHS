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
    
    var sectionArray : [SectionModel]? = [SectionModel()] {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !sectionArray![section].collapsed {
            return 0
        }
        return sectionArray![section].cells.count
        
        //        return sectionArray![section].collapsed ? sectionArray![section].cells.count : 0
    }
    
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let section = indexPath.section
        if SELECTEDLANGID == LangID.PERSIAN || SELECTEDLANGID == LangID.ARABIC {
            let cell = CellRooms(frame: CGRectMake(0 , 0 , tableView.frame.width , 80))
            cell.selectionStyle = .None
            cell.labelText = sectionArray![section].cells[indexPath.row].name
            cell.imgImage = UIImage(named: sectionArray![section].cells[indexPath.row].icon)!
            
            return cell
        }
        let cell = CellRoomsLeftAllignment(frame: CGRectMake(0 , 0 , tableView.frame.width , 80))
        cell.selectionStyle = .None
        cell.labelText = sectionArray![section].cells[indexPath.row].name
        //Arash: Bug(image name sent by center is not a valid image in assets.)
        cell.imgImage = UIImage(named: sectionArray![section].cells[indexPath.row].icon)!
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let vc = story.instantiateViewControllerWithIdentifier("favoritesVC") as! FavoritesVC
        vc.type = .rooms
        vc.topBarBackTitle = "\(sectionArray![indexPath.section].name) / \(sectionArray![indexPath.section].cells[indexPath.row].name)"
        presentViewController(vc, animated: true, completion: nil)
    }
    
    
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.clearColor()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bgMain")!)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.backgroundColor = UIColor.clearColor()
        //        fetchAndRefresh()
        
        // BinMan1 : Notificatoins comming
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.updateView(_:)), name: SECTION_UPDATE_VIEW, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.updateView(_:)), name: ROOM_UPDATE_VIEW, object: nil)
    }
    
    /// Arash : Reloaddata for different view allignments.
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // BinMan1 : Update View for first Time after loaded this view controller
        fetchAndRefresh()
    }
    
    /// Arash : Set sectionroom click .
    func sectionRoomClick(sectionRooms : SectionRooms , viewForHeaderInSection section: Int) {
        sectionRooms.sectionID = section
        sectionRooms.context = self
        sectionRooms.text = sectionArray![section].name
        sectionRooms.setImage = UIImage(named: sectionArray![section].icon)
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
        sectionRooms.text = sectionArray![section].name
        sectionRooms.setImage = UIImage(named: sectionArray![section].icon)
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
