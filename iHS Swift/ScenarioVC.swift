//
//  ScenarioVC.swift
//  iHS Swift
//
//  Created by arash on 11/10/16.
//  Copyright © 2016 Ali Zare Sh. All rights reserved.
//

/*
 Arash : Section2 - Scenario View Controller
 */

import UIKit

class ScenarioVC: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    /// Arash: reload the tableview.
    var scenarioArray = [ScenarioModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return scenarioArray.count
    }
    
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = CellScenarios(frame: CGRectMake(0 , 0 , tableView.frame.width , 80))
        cell.selectionStyle = .None
        return cell
    }
    
    internal func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewControllerWithIdentifier("scenarioDetailVC") as! ScenarioDetailVC
        vc.scenarioID = scenarioArray[indexPath.row].id
        presentViewController(vc, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 80
    }
    
    
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.clearColor()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bgMain")!)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.backgroundColor = UIColor.clearColor()
        
        // BinMan1 : Notifcation observer for update view
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.updateView(_:)), name: SCENARIO_UPDATE_VIEW, object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // BinMan1 : Update View for first Time after loaded this view controller
        fetchAndRefresh()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /// BinMan1 : fetch data from db and refresh view
    private func fetchAndRefresh() {
        scenarioArray = DBManager.getAllScenarios()!
    }
    
    /// BinMan1 : observer for update scenario
    @objc private func updateView(notification : NSNotification ) {
        fetchAndRefresh()
    }
}
