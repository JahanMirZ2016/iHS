//
//  CellScenarios.swift
//  iHS Swift
//
//  Created by arash on 12/10/16.
//  Copyright © 2016 Ali Zare Sh. All rights reserved.
//

/*
 Arash : Cell for scenario viewcontroller.(tableview)
 */

import UIKit

class CellScenarios: UITableViewCell {
    
    var context:ScenarioVC!
    var indexPath:NSIndexPath!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var labelDes: UILabel!
    
    var textName:String? {
        get {
            return labelName.text
        }
        set {
            labelName.text = newValue
        }
    }
    
    var textDes:String? {
        get {
            return labelDes.text
        }
        set {
            labelDes.text = newValue
        }
    }
    
    //    var textDescription:String? {
    //        get {
    //            return labelDescription.text
    //        }
    //        set {
    //            labelDescription.text = newValue
    //        }
    //    }
    
    var setImage:UIImage? {
        get {
            return nil
        }
        set {
            img.image = newValue
        }
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createNib()
    }
    
    @IBOutlet var view : UIView!
    
    func createNib() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "CellScenarios", bundle: bundle)
        
        
        view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth , UIViewAutoresizing.FlexibleHeight]
        
        addSubview(view)
    }
    
    ///Arash: Perform a segue to ScenarioDetailsVC.
    @IBAction func gestureSegue(sender: UITapGestureRecognizer) {
        print("A")
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewControllerWithIdentifier("scenarioDetailVC") as! ScenarioDetailVC
        vc.scenarioID = context.scenarioArray[indexPath.row].id
        context.presentViewController(vc, animated: true, completion: nil)
        vc.scenarioModel = context.scenarioArray[indexPath.row]
    }
    
}
