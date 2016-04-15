//
//  ViewController.swift
//  Carpooling
//
//  Created by Sanjay Shrestha on 3/31/16.
//  Copyright © 2016 St Marys. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {


    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet var background: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        if NSUserDefaults.standardUserDefaults().valueForKey("uid") != nil && CURRENT_USER.authData != nil
        {
           // self.logoutButton.hidden = false
        }
    }
    
    
    @IBAction func loginAction(sender: AnyObject)
    {
        let email = self.emailTextField.text
        let password = self.passwordTextField.text
        
        if email != "" && password != ""
        {
            FIREBASE_REF.authUser(email, password: password, withCompletionBlock: { error, authData in
                
                if error == nil
                {
                    NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
                    print("Logged In :)")
                    self.logoutButton.hidden = false
                }
                else
                {
                    print(error)
                }
            })
        }
        else
        {
            let alert = UIAlertController(title: "Error", message: "Enter Email and Password.", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }

    
    @IBAction func logoutAction(sender: AnyObject)
    {
        CURRENT_USER.unauth()
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "uid")
        self.logoutButton.hidden = true
    }

}

