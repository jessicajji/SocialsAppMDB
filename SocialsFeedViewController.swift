//
//  SocialsFeedViewController.swift
//  SocialApp
//
//  Created by Jessica Ji on 3/9/16.
//  Copyright © 2016 Jessica Ji. All rights reserved.
//

import UIKit

class SocialsFeedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var selectedSocial = ""
    
    var socialsArray = []
    var index = Int()
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidAppear(animated: Bool) {
        self.viewDidLoad()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let query = PFQuery(className: "Socials")
        do {
            self.socialsArray = try query.findObjects()
           
        } catch {
            print("Error")
        }
        
        self.collectionView.reloadData()

        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return socialsArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("socialCell", forIndexPath: indexPath) as! SocialCellCollectionViewCell
        cell.socialName.text = socialsArray[indexPath.item]["socialTitle"] as? String
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMM dd, yyyy hh:mm a"
        let date = socialsArray[indexPath.item]["socialTime"] as! NSDate
        let dateString = formatter.stringFromDate(date)
        var index1 = dateString.startIndex.advancedBy(6)
        let final = dateString.substringToIndex(index1)
        cell.socialDate.text = final
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("toDetails", sender: self)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "toDetails") {
            let vc = (segue.destinationViewController as! SocialDetailsViewController)
            vc.socialsArray = socialsArray
            vc.index = index
        }
    }
    
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        index = indexPath.item
        return true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
