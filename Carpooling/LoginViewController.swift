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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailField.delegate = self
        self.passwordField.delegate = self
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        // Attempt to sign in silently, this will succeed if
        // the user has recently been authenticated
        GIDSignIn.sharedInstance().signInSilently()
        
        
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

    

    

