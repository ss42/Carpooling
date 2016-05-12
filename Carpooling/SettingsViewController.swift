//
//  SettingsViewController.swift
//  Carpooling
//
//  Created by Sanjay Shrestha on 5/11/16.
//  Copyright © 2016 St Marys. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    
    @IBOutlet weak var phoneSwitch: UISwitch!
    
    
    @IBOutlet weak var textMessageSwitch: UISwitch!
    
    
    @IBOutlet weak var emailSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func phoneSwitchChanged(sender: UISwitch) {
       // phoneSwitch.on = false

        
    }
    
    
    @IBAction func textMessageSwitchChanged(sender: AnyObject) {
        
        //textMessageSwitch.on = false
    }
    
    @IBAction func emailSwitchChanged(sender: AnyObject) {
       // emailSwitch.on = false
    }

    @IBAction func submitPressed(sender: AnyObject) {
        
        
        if !phoneSwitch.on && !emailSwitch.on && !textMessageSwitch.on {
            self.alert("Attention!", msg: "You need to have at least one medium of communication")
            
        }
        else{
            if phoneSwitch.on {
                NSUserDefaults.standardUserDefaults().setObject(phoneSwitch.on, forKey: "phone")

            }
            if emailSwitch.on {
                NSUserDefaults.standardUserDefaults().setObject(emailSwitch.on, forKey: "email")
            }
            if textMessageSwitch.on {
                NSUserDefaults.standardUserDefaults().setObject(textMessageSwitch.on, forKey: "text")
            }

        }
        
        
    }
    func alert(title: String, msg: String){
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: title, style: .Default, handler: nil))
        
        presentViewController(alertController, animated: true, completion: nil)
        
    }

}
