//
//  ProfileViewController.swift
//  Carpooling
//
//  Created by Sanjay Shrestha on 4/11/16.
//  Copyright © 2016 St Marys. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController , UITextFieldDelegate{
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var editProfilePictureButton: UIButton!
    
    @IBOutlet weak var ScrollView: UIScrollView!
    
    var currentUser = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        confirmDelegate()
        // Do any additional setup after loading the view, typically from a nib.
       /**let userUID = DataService.dataService.userRef
        DataService.dataService.userRef.observeAuthEventWithBlock({
            authData in
            if authData != nil{
                self.currentUser = authData.uid
                
            }
            else
            {
                
            }
        })
        
        **/
        
        //if (NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String == DataService.dataService.userRef
    }
    
    func confirmDelegate(){
        self.firstName.delegate = self
        self.lastName.delegate = self
        self.phoneNumber.delegate = self
        self.emailAddress.delegate = self

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
        let first = firstName.text
        let last = lastName.text
        let phone = phoneNumber.text
        let email = emailAddress.text
        
        let user: NSDictionary = ["first": first!, "last": last!, "phone": phone!, "email" : email!]
        DataService.dataService.userRef.childByAppendingPath(currentUser).updateChildValues(user as! Dictionary<String, AnyObject>)

        
        performCustomSegue()
    }
    
    @IBAction func editButtonTapped(sender: AnyObject) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .PhotoLibrary
        presentViewController(picker, animated: true, completion: nil)
        
    }
    
    func performCustomSegue(){
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewControllerWithIdentifier("home")
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        ScrollView.setContentOffset(CGPointMake(0, 0), animated: true)
        return false
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if (textField == emailAddress) || (textField == phoneNumber){
            ScrollView.setContentOffset(CGPointMake(0, 250), animated: true)

        }
    }
    
}

extension ProfileViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        profileImage.image = image
        
        let imageData = UIImagePNGRepresentation(image)
        let base64String = imageData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        //newPost?.image = base64String
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        //self.savedImageAlert()
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    // MARK:- UIImagePickerControllerDelegate methods
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        profileImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        let imageToSave: UIImage = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
        
        var data: NSData = NSData()
        
        if let image = profileImage.image {
            data = UIImageJPEGRepresentation(image, 0.75)!
        }
        
        var base64String = data.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //read abd decode
    /*imageRef.observeEventType(.Value, withBlock: { snapshot in
     
     let base64EncodedString = snapshot.value
     let imageData = NSData(base64EncodedString: base64EncodedString as! String,
     options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
     let decodedImage = NSImage(data:imageData!)
     self.myImageView.image = decodedImage
     
     }, withCancelBlock: { error in
     print(error.description)
     })*/
    
    
}