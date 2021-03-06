//
//  SignupViewController.swift
//  SocialApp
//
//  Created by Jessica Ji on 3/8/16.
//  Copyright © 2016 Jessica Ji. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func continueSignup(sender: AnyObject) {
            let user = PFUser()
            user.username = username.text
            user.password = password.text
            user.email = email.text
        
            user.signUpInBackground()
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
