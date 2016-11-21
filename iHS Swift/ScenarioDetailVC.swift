//
//  ScenarioDetailVC.swift
//  iHS Swift
//
//  Created by arash on 11/21/16.
//  Copyright © 2016 Ali Zare Sh. All rights reserved.
//

import UIKit

class ScenarioDetailVC: UIViewController , UICollectionViewDataSource , UICollectionViewDelegate  {
    @IBOutlet weak var btnDescription: UIButton!
    @IBOutlet weak var btnConditions: UIButton!
    @IBOutlet weak var btnResults: UIButton!
    @IBOutlet weak var viewCollection: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cellScenarioDetail", forIndexPath: indexPath)
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(collectionView.frame.width - 8, collectionView.frame.height)
        
    }
    
    /// Arash : Set header images.
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0: setImageDescription()
            break
        case 1: setImageConditions()
            break
        case 2: setImageResults()
            break
        default: break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bgMain")!)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let headerTitles = DBManager.getTranslationOfSentences(SentencesID: [17 , 18 , 19])
        btnDescription.setTitle(headerTitles[0], forState: .Normal)
        btnConditions.setTitle(headerTitles[1], forState: .Normal)
        btnResults.setTitle(headerTitles[2], forState: .Normal)
    }
    

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        roundCollectionView()
    }
    
    /// Arash : Corner radious for collectionview (for its parent.)
    private func roundCollectionView() {
        let path = UIBezierPath(roundedRect: viewCollection.bounds, byRoundingCorners: [.BottomLeft , .BottomRight], cornerRadii: CGSizeMake(35, 35))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.CGPath
        viewCollection.layer.mask = maskLayer
    }
    
    
    @IBAction func selectorDescription(sender: UIButton) {
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .None, animated: false)
        setImageDescription()
        
    }
    
    @IBAction func selectorConditions(sender: UIButton) {
        let indexPath = NSIndexPath(forRow: 1, inSection: 0)
        collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .None, animated: false)
        setImageConditions()
    }
    
    @IBAction func selectorResults(sender: UIButton) {
        let indexPath = NSIndexPath(forRow: 2, inSection: 0)
        collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .None, animated: false)
        setImageResults()
        
    }
    
    /// Arash : Set header images when description selected scrolled to..
    private func setImageDescription() {
        btnDescription.setBackgroundImage(UIImage(named: "ScenarioHeader2"), forState: .Normal)
        btnResults.setBackgroundImage(UIImage(named: "ScenarioHeader1"), forState: .Normal)
        btnConditions.setBackgroundImage(UIImage(named: "ScenarioHeader1"), forState: .Normal)
    }
    
    /// Arash : Set header images when conditions selected or scrolled to.
    private func setImageConditions() {
        btnDescription.setBackgroundImage(UIImage(named: "ScenarioHeader1"), forState: .Normal)
        btnResults.setBackgroundImage(UIImage(named: "ScenarioHeader1"), forState: .Normal)
        btnConditions.setBackgroundImage(UIImage(named: "ScenarioHeader2"), forState: .Normal)
    }
    
    /// Arash : Set header images when results selected or scrolled to.
    private func setImageResults() {
        btnDescription.setBackgroundImage(UIImage(named: "ScenarioHeader1"), forState: .Normal)
        btnResults.setBackgroundImage(UIImage(named: "ScenarioHeader2"), forState: .Normal)
        btnConditions.setBackgroundImage(UIImage(named: "ScenarioHeader1"), forState: .Normal)
    }
    
}
