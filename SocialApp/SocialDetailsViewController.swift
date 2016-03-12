//
//  SocialDetailsViewController.swift
//  SocialApp
//
//  Created by Jessica Ji on 3/9/16.
//  Copyright © 2016 Jessica Ji. All rights reserved.
//

import UIKit

class SocialDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //var socialName = ""
    var index = Int()
    var socialsArray = []
    var goingNames = NSMutableArray()
    
    @IBOutlet var nameField: UILabel!
    @IBOutlet var timeField: UILabel!
    @IBOutlet var locationField: UILabel!
    @IBOutlet var infoField: UILabel!
    
    @IBOutlet var goingTableView: UITableView!
    
    @IBAction func goBack(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    @IBAction func rsvpGoing(sender: AnyObject) {
        let social = socialsArray[index] as! PFObject
        social.addUniqueObject((PFUser.currentUser()?.objectId)!, forKey: "goingUserObjectIds")
        social.saveInBackground()
        goingTableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        // query for going users
        // spinner
        
        let query = PFQuery(className: "_User")
        let goingIds = self.socialsArray[self.index]["goingUserObjectIds"]
        print(goingIds)
        print((goingIds as! NSArray).count)
        if (goingIds != nil) {
            query.whereKey("objectId", containedIn: goingIds as! NSArray as [AnyObject])
            query.findObjectsInBackgroundWithBlock {
                (objects: [PFObject]?, error: NSError?) -> Void in
                if error == nil {
                    if let objects = objects {
                        for object in objects {
                            self.goingNames.addObject(object["username"])
                            self.goingTableView.reloadData()

                            
                        }
                    }
                }
            }
            
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goingTableView.delegate = self
        goingTableView.dataSource = self

        nameField.text = socialsArray[index]["socialTitle"] as? String
        locationField.text = socialsArray[index]["socialLocation"] as? String
        infoField.text = socialsArray[index]["socialInformation"] as? String
        
        // set date
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMM dd, yyyy hh:mm a"
        let date = socialsArray[index]["socialTime"] as! NSDate
        let dateString = formatter.stringFromDate(date)
        timeField.text = dateString
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goingNames.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("goingUser", forIndexPath: indexPath) as! GoingTableViewCell
        
        cell.userName.text = goingNames[indexPath.row] as! String
        print("length: ")
        print(goingNames.count)
        print(cell.userName.text)
        return cell
    }

}
