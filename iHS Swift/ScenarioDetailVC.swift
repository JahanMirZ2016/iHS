//
//  ScenarioDetailVC.swift
//  iHS Swift
//
//  Created by arash on 11/21/16.
//  Copyright © 2016 Ali Zare Sh. All rights reserved.
//

/*
 Arash: Section2 - Secondary - ScenarioDetail View Controller
 */

import UIKit

class ScenarioDetailVC: UIViewController , UICollectionViewDataSource , UICollectionViewDelegate  {
    @IBOutlet weak var btnDescription: UIButton!
    @IBOutlet weak var btnConditions: UIButton!
    @IBOutlet weak var btnResults: UIButton!
    @IBOutlet weak var viewCollection: UIView!
    var alertView:AlertScenarioDetail?
    @IBOutlet weak var topBar: TopBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var topBarScenario: TopBarScenario!
    
    
    
    /// Arash: Selected scenario ID.
    var scenarioID:Int = -1
    
    /// Arash: reload the collectionview.
    var scenarioModel = ScenarioModel() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cellScenarioDetail", forIndexPath: indexPath) as! ScenarioDetailCell
        
        // Arash: Set description, condition and result webViews.
        switch indexPath.row {
        case 0 :
            cell.webView.loadHTMLString(scenarioModel.description, baseURL: nil)
            break
        case 1 :
            cell.webView.loadHTMLString(scenarioModel.condition, baseURL: nil)
            break
        case 2 :
            cell.webView.loadHTMLString(scenarioModel.result, baseURL: nil)
            break
        default: break
        }
        
        cell.tag = indexPath.row
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(collectionView.frame.width - 8, collectionView.frame.height)
        
    }
    
    /// Arash: Set header images.
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: self.collectionView.contentOffset, size: self.collectionView.bounds.size)
        let visiblePoint = CGPointMake(CGRectGetMidX(visibleRect), CGRectGetMidY(visibleRect))
        let visibleIndexPath = self.collectionView.indexPathForItemAtPoint(visiblePoint)
        if let v = visibleIndexPath {
            switch v.item {
            case 0: setImageDescription()
                break
            case 1: setImageConditions()
                break
            case 2: setImageResults()
                break
            default: break
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bgMain")!)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(updateView), name: SCENARIO_UPDATE_VIEW, object: nil)
        topBarScenario.context = self
        topBarScenario.scenarioModel = scenarioModel
        
    }
    
    /// Arash: Observer for Sectoins updated.(collectionview updated.)
    @objc private func updateView(notification : NSNotification) {
        fetchAndRefresh()
    }
    
    /// Arash: Fetch all data and refresh view.
    private func fetchAndRefresh() {
        scenarioModel = DBManager.getScenario(ScenarioID: scenarioID)!
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        manageTopBar()
        let headerTitles = DBManager.getTranslationOfSentences(SentencesID: [17 , 18 , 19])
        btnDescription.setTitle(headerTitles[0], forState: .Normal)
        btnConditions.setTitle(headerTitles[1], forState: .Normal)
        btnResults.setTitle(headerTitles[2], forState: .Normal)
        fetchAndRefresh()
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        roundCollectionView()
    }
    
    /// Arash: Corner radious for collectionview (for its parent.)
    private func roundCollectionView() {
        let path = UIBezierPath(roundedRect: viewCollection.bounds, byRoundingCorners: [.BottomLeft , .BottomRight], cornerRadii: CGSizeMake(35, 35))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.CGPath
        viewCollection.layer.mask = maskLayer
    }
    
    /// Arash: Description button clicked. (switch to Description)
    @IBAction func selectorDescription(sender: UIButton) {
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .None, animated: false)
        setImageDescription()
        
    }
    
    /// Arash: Conditions button clicked. (switch to Conditions)
    @IBAction func selectorConditions(sender: UIButton) {
        let indexPath = NSIndexPath(forRow: 1, inSection: 0)
        collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .None, animated: false)
        setImageConditions()
    }
    
    /// Arash: Results button clicked. (switch to Results)
    @IBAction func selectorResults(sender: UIButton) {
        let indexPath = NSIndexPath(forRow: 2, inSection: 0)
        collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .None, animated: false)
        setImageResults()
        
    }
    
    /// Arash: Set header images when description selected scrolled to.
    private func setImageDescription() {
        btnDescription.setBackgroundImage(UIImage(named: "ScenarioHeader2"), forState: .Normal)
        btnResults.setBackgroundImage(UIImage(named: "ScenarioHeader1"), forState: .Normal)
        btnConditions.setBackgroundImage(UIImage(named: "ScenarioHeader1"), forState: .Normal)
    }
    
    /// Arash: Set header images when conditions selected or scrolled to.
    private func setImageConditions() {
        btnDescription.setBackgroundImage(UIImage(named: "ScenarioHeader1"), forState: .Normal)
        btnResults.setBackgroundImage(UIImage(named: "ScenarioHeader1"), forState: .Normal)
        btnConditions.setBackgroundImage(UIImage(named: "ScenarioHeader2"), forState: .Normal)
        
    }
    
    /// Arash: Set header images when results selected or scrolled to.
    private func setImageResults() {
        btnDescription.setBackgroundImage(UIImage(named: "ScenarioHeader1"), forState: .Normal)
        btnResults.setBackgroundImage(UIImage(named: "ScenarioHeader2"), forState: .Normal)
        btnConditions.setBackgroundImage(UIImage(named: "ScenarioHeader1"), forState: .Normal)
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
    
    ///Arash: Show alert dialog if scenario state == -1
    func showAlert() {
        alertView = AlertScenarioDetail(frame: CGRect(x: 0, y: 0, width: WIDTHPHONE, height: HEIGHTPHONE))
        alertView?.labelMessage.numberOfLines = 3
        alertView?.labelMessage.text = DBManager.getTranslationOfSentences(SentencesID: [29])[0]
        if SELECTEDLANGID == LangID.PERSIAN || SELECTEDLANGID == LangID.ARABIC {
            alertView?.labelMessage.textAlignment = .Right
        }
        alertView?.btnOK.setTitle("OK", forState: .Normal)
        alertView!.context = self
        view.addSubview(alertView!)
    }
    
    ///Arash: Hide alert dialog
    func hideAlert() {
        alertView?.removeFromSuperview()
    }
    
    
}
