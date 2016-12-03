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
    
    @IBOutlet var collectionView: UICollectionView!
    
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bgMain")!)
        fetchAndRefresh()
        
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
        nodeArray = DBManager.getAllFavorites()!
        collectionView.reloadData()
    }
    
    
    
}
