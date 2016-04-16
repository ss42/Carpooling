//
//  ProfileViewController.swift
//  Carpooling
//
//  Created by Sanjay Shrestha on 4/11/16.
//  Copyright © 2016 St Marys. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var editProfilePictureButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
 
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelTapped(sender: AnyObject) {
        performCustomSegue()
    }
    
    
    @IBAction func SaveTapped(sender: AnyObject) {
        performCustomSegue()
    }
    
    @IBAction func editButtonTapped(sender: AnyObject) {
    }
    
    func performCustomSegue(){
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        //let vc: UINavigationController = storyboard.instantiateViewControllerWithIdentifier("navView") as! UINavigationController
        
        let vc: UIViewController = storyboard.instantiateViewControllerWithIdentifier("home")
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
}