//
//  SlideOutMenuController.swift
//  Carpooling
//
//  Created by Sanjay Shrestha on 4/2/16.
//  Copyright © 2016 St Marys. All rights reserved.
//

import UIKit
import Firebase
import Google

class SlideOutMenuController: UITableViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .None
        
        if let imageData = NSUserDefaults.standardUserDefaults().objectForKey("image") as? NSData{
            let storedImage = UIImage.init(data: imageData)
            profileImage.image = storedImage
            }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func signOutTapped(sender: AnyObject) {
        print("loggin out started")
        DataService.dataService.userRef.unauth()
        
        GIDSignIn.sharedInstance().signOut()

        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "uid")
        let loginViewController = self.storyboard!.instantiateViewControllerWithIdentifier("Login")
        UIApplication.sharedApplication().keyWindow?.rootViewController = loginViewController
        print("loged out")
    }
    

}
