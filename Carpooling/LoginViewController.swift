//
//  ViewController.swift
//  Carpooling
//
//  Created by Sanjay Shrestha on 3/31/16.
//  Copyright © 2016 St Marys. All rights reserved.
//

import UIKit
import Firebase
import Google




class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    var tempImage: UIImage?

    @IBOutlet weak var ScrollView: UIScrollView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var pageControlView: UIView!
    
    @IBOutlet weak var pageControlLabel: UILabel!
    
    @IBOutlet weak var pageControlImageView: UIImageView!
    
    var pageTitles: NSArray!
    var pageImages: NSArray!
    
    // create swipe gesture
    let swipeGestureLeft = UISwipeGestureRecognizer()
    let swipeGestureRight = UISwipeGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailField.delegate = self
        self.passwordField.delegate = self
        
        self.pageTitles = NSArray(objects: "Students have a hard time coming to Saint Marys, Lets help each other. #SMCDOESCARE","Lets bring less cars to college and help the environment","Make extra cash while you are going to college")
        self.pageImages = NSArray(objects: "requestRide", "Carpool", "Carpool")
        
       /* GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        // Attempt to sign in silently, this will succeed if
        // the user has recently been authenticated
        GIDSignIn.sharedInstance().signInSilently()*/
        
        // set gesture direction
        self.swipeGestureLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.swipeGestureRight.direction = UISwipeGestureRecognizerDirection.Right
        // add gesture target
        self.swipeGestureLeft.addTarget(self, action: #selector(LoginViewController.handleSwipeLeft(_:)))
        self.swipeGestureRight.addTarget(self, action: #selector(LoginViewController.handleSwipeRight(_:)))
        self.pageControlView.addGestureRecognizer(self.swipeGestureLeft)
        self.pageControlView.addGestureRecognizer(self.swipeGestureRight)
        self.setCurrentPageLabel()


    }
    // MARK: - Utility function
    
    // increase page number on swift left
    func handleSwipeLeft(gesture: UISwipeGestureRecognizer){
        self.pageController()

    }
    
    // reduce page number on swift right
    func handleSwipeRight(gesture: UISwipeGestureRecognizer){
        
       self.pageController()
        
        
    }
    func pageController(){
        if self.pageControl.currentPage == 0 {
             self.pageControlLabel.text = self.pageTitles[0] as? String
            self.pageControlImageView.image = UIImage(named: self.pageImages[0] as! String)
        }
        else if self.pageControl.currentPage == 1 {
            self.pageControlLabel.text = self.pageTitles[1] as? String
            self.pageControlImageView.image = UIImage(named: self.pageImages[1] as! String)
        }
        else if self.pageControl.currentPage == 2 {
            self.pageControlLabel.text = self.pageTitles[2] as? String
            self.pageControlImageView.image = UIImage(named: self.pageImages[2] as! String)
        }
    }
    
    // set current page number label
    private func setCurrentPageLabel(){
        //self.pageControlLabel.text = "\(self.pageControl.currentPage + 1)"
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
      
        // If we have the uid stored, the user is already logger in - no need to sign in again!
        if NSUserDefaults.standardUserDefaults().valueForKey("uid") != nil && DataService.dataService.CURRENT_USER_REF.authData != nil {
            DataService.dataService.CURRENT_USER_REF.queryOrderedByKey().observeEventType(.Value, withBlock: {
                snapshot in
                
                /*
                 let imageString = nil//snapshot.value["image"] as? String
                
                if  imageString != nil {
                    print("image not empty")
                    print(imageString)
                    let image = self.convertBase64StringToUImage(imageString!)
                  //  self.tempImage! = image
                    //self.saveImageToNSUserDefault(self.tempImage!)
                    
                    
                    let imageData = UIImageJPEGRepresentation(image, 0.75)
                    //saveData.setObject(imageData, forKey: "image")
                    NSUserDefaults.standardUserDefaults().setObject(imageData, forKey: "image")
                }
                else {
                    print("No photo")
                    //self.profileImage.image = UIImage(named: "male")
                }
 */
            })
            
            //go to next screen cuz the user is sign in
            self.performSegueWithIdentifier("CurrentlyLoggedIn", sender: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func convertBase64StringToUImage(baseString: String)-> UIImage {
        let decodedData = NSData(base64EncodedString: baseString, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
        let decodedimage = UIImage(data: decodedData!)
        //println(decodedimage)
        return decodedimage! as UIImage
    }
    
  /*
    func saveImageToNSUserDefault(image: UIImage){
        let saveData = NSUserDefaults.standardUserDefaults()
        let imageData = UIImageJPEGRepresentation(image, 0.75)
        saveData.setObject(imageData, forKey: profileImage)
    }
    
        
    }
    //To get info back from NSUSEr
    
    if let imageData = saveData.objectForKey(profileImage) as? NSData{
        let storedImage = UIImage.init(data: imageData)
     profileImage.image = storedImage
     */
    
    // Implement the required GIDSignInDelegate methods
  
    
    
    @IBAction func tryLogin(sender: AnyObject) {
        let email = emailField.text
        let password = passwordField.text
        
        if email != "" && password != "" {
            
            // Login with the Firebase's authUser method
            
            DataService.dataService.baseRef.authUser(email, password: password, withCompletionBlock: { error, authData in
                
                if error != nil {
                    print(error)
                    self.loginErrorAlert("Oops!", message: "Check your username and password.")
                } else {
                    
                    // Be sure the correct uid is stored.
                    
                    NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
                    
                    // Enter the app!
                    
                    self.performSegueWithIdentifier("CurrentlyLoggedIn", sender: nil)
                }
            })
            
        } else {
            
            // There was a problem
            
            loginErrorAlert("Oops!", message: "Don't forget to enter your email and password.")
        }
        
    }
    
    func loginErrorAlert(title: String, message: String) {
        
        // Called upon login error to let the user know login didn't work.
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
  
    
}
/*

extension LoginViewController: GIDSignInDelegate,  GIDSignInUIDelegate{
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
                withError error: NSError!) {
        if (error == nil) {
            // Auth with Firebase
            DataService.dataService.userRef.authWithOAuthProvider("google", token: user.authentication.accessToken, withCompletionBlock: { (error, authData) in
                // User is logged in!
                
                let uid = user.userID
                let first = user.profile.name
                let last = user.profile.familyName
                let email = user.profile.email
                
                let user = ["first": first!, "email": email!, "last": last!]
                
                // Seal the deal in DataService.swift.
                DataService.dataService.createNewAccount(uid, user: user)
                
                self.performSegueWithIdentifier("CurrentlyLoggedIn", sender: nil)
                
            })
        } else {
            // Don't assert this error it is commonly returned as nil
            print("\(error.localizedDescription)")
        }
    }
    
    
    
    // Implement the required GIDSignInDelegate methods
    // Unauth when disconnected from Google
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
                withError error: NSError!) {
        DataService.dataService.userRef.unauth();
    }
    
    func authenticateWithGoogle(sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    func signOut() {
        GIDSignIn.sharedInstance().signOut()
        DataService.dataService.userRef.unauth()
    }

}
 */


extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        ScrollView.setContentOffset(CGPointMake(0, 0), animated: true)
        return false
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        ScrollView.setContentOffset(CGPointMake(0, 250), animated: true)
    }
}

    

 
