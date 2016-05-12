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
    
    @IBOutlet weak var profileNAme: UILabel!
    
    var currentUserUID = ""
    var fullName = "User"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .None
        
        if let imageData = NSUserDefaults.standardUserDefaults().objectForKey("image") as? NSData{
            let storedImage = UIImage.init(data: imageData)
            profileImage.image = storedImage
            }
        DataService.dataService.userRef.observeAuthEventWithBlock({
            authData in
            print("hello world")
            if authData != nil{
                self.currentUserUID = authData.uid
                self.updateInfoFromDatabase()
                
            }
            else
            {
                print("authdata is nil")
            }
        })
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        print("view load")
        self.profileNAme.text = self.fullName
        print(self.fullName)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func signOutTapped(sender: AnyObject) {
        
        print("loggin out started")
        DataService.dataService.userRef.unauth()
        
        GIDSignIn.sharedInstance().signOut()
        
        
        //SettingNSUserDefault to nil when sign out
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "uid")
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "image")
        let loginViewController = self.storyboard!.instantiateViewControllerWithIdentifier("Login")
        UIApplication.sharedApplication().keyWindow?.rootViewController = loginViewController
        print("loged out")
    }
    func updateInfoFromDatabase(){
        let newRef = Firebase(url: "http://smcpool.firebaseio.com/users/\(currentUserUID)")
        newRef.queryOrderedByKey().observeEventType(.Value, withBlock: {
            snapshot in
            
            print("Inside update from database func")
            let first = snapshot.value["first"] as? String
            let last = snapshot.value["last"] as? String
      
           // let imageString = snapshot.value["image"] as? String
     
            self.fullName = "\(first!) \(last!)"
            print(self.fullName)
            
        })
    }
    
    

}
