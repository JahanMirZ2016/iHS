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
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let vc = story.instantiateViewControllerWithIdentifier("deviceVC")
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
        fetchAndRefresh()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(updateView), name: NODE_UPDATE_VIEW, object: nil)
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
            nodeArray = DBManager.getAllNodes()!
        }
        collectionView.reloadData()
    }
    
    
    
}
