//
//  FavoritesVC.swift
//  iHS Swift
//
//  Created by arash on 11/10/16.
//  Copyright © 2016 Ali Zare Sh. All rights reserved.
//


/*
 Arash : Section2 - Favorites View Controller
 */

import UIKit

class FavoritesVC: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    var topBarBackTitle = ""
    var type = NodeType.favorites
    var roomModel:RoomModel?
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var topBar: TopBar!
    @IBOutlet weak var topBarBack: TopBarRooms!
    
    
    
    /// Arash: reload the collectionview.
    //    var nodeArray = [NodeModel]() {
    //        didSet {
    //            collectionView.reloadData()
    //        }
    //    }
    var nodeArray = [NodeModel() , NodeModel()]
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nodeArray.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(WIDTHPHONE/4 ,WIDTHPHONE/4)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cellFavorites", forIndexPath: indexPath) as! CellFavorites
        cell.image = nodeArray[indexPath.item].icon
        cell.text = nodeArray[indexPath.item].name
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let vc = story.instantiateViewControllerWithIdentifier("deviceVC") as! DeviceVC
        let nodeModel = nodeArray[indexPath.row]
        vc.nodeModel = nodeModel
        presentViewController(vc, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bgMain")!)
        fetchAndRefresh()
        if type == .rooms {
            topBarBack.hidden = false
            topBarBack.context = self
            topBarBack.setText = topBarBackTitle
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        topBar.viewController = self
        fetchAndRefresh()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(updateView), name: NODE_UPDATE_VIEW, object: nil)
        manageTopBar()
    }
    
    
    /// Arash: Observer for Sectoins updated.(collectionview updated.)
    @objc private func updateView(notification : NSNotification) {
        fetchAndRefresh()
    }
    
    /// Arash: Fetch all data and refresh view
    private func fetchAndRefresh() {
        if type == .favorites {
            nodeArray = DBManager.getAllFavorites()!
        }else {
            nodeArray = DBManager.getAllRoomNodes(roomModel!.id)!
        }
        collectionView.reloadData()
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
    
    ///Arash: Change statusbar style(light content color)
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
}
