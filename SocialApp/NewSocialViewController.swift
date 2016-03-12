//
//  NewSocialViewController.swift
//  SocialApp
//
//  Created by Jessica Ji on 3/9/16.
//  Copyright © 2016 Jessica Ji. All rights reserved.
//

import UIKit

class NewSocialViewController: UIViewController {
    
    
    @IBOutlet var eventName: UITextField!
    @IBOutlet var eventLocation: UITextField!
    @IBOutlet var additionalInfo: UITextField!
    
    @IBOutlet var MMM: UITextField!
    @IBOutlet var d: UITextField!
    @IBOutlet var yyyy: UITextField!
    @IBOutlet var hhmm: UITextField!
    @IBOutlet var ampm: UITextField!
    
    
    @IBAction func cancelSocial(sender: AnyObject) {
         self.dismissViewControllerAnimated(true, completion: {})
    }
    
    @IBAction func postSocial(sender: AnyObject) {
        //dateFormatter.timeZone = NSTimeZone.localTimeZone()
        
        // make Date string
        let day = String(d.text!)
        let year = String(yyyy.text!)
        let time = String(hhmm.text!)
        let dateString = MMM.text! + " " + day + ", " + year + " " + time + " " + ampm.text!
        
//        let dateString = "MAR 07, 2016 07:30 AM"
        
        // extract NSDate
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMM dd, yyyy hh:mm a"
        let from = formatter.dateFromString(dateString)
        
        
        // make social object
        let social = PFObject(className:"Socials")
        social["socialTime"] = from
        social["socialTitle"] = eventName.text!
        social["socialLocation"] = eventLocation.text!
        social["socialInformation"] = additionalInfo.text!
        social["goingUserObjectIds"] = []
        
        // TO DO: add user that's creating to the <going array>
        
        social.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                // incorrect fields
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
