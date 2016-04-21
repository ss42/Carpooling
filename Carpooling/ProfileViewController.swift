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
    
    var imageString = ""
    var currentUser = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        confirmDelegate()
        // Do any additional setup after loading the view, typically from a nib.
        _ = DataService.dataService.userRef
        DataService.dataService.userRef.observeAuthEventWithBlock({
            authData in
            if authData != nil{
                self.currentUser = authData.uid
                print("The UID for current user is \(self.currentUser)")
               // self.updateInfoFromDatabase()
            }
            else
            {
                
            }
        })
        
        
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
        let image = self.convertToBase64String(profileImage.image!)
        let user: NSDictionary = ["first": first!, "last": last!, "phone": phone!, "email" : email!, "image": image]
        DataService.dataService.userRef.childByAppendingPath(currentUser).updateChildValues(user as! Dictionary<String, AnyObject>)
        
        
        performCustomSegue()
    }
    
    @IBAction func editButtonTapped(sender: AnyObject) {
        /*
         let picker = UIImagePickerController()
         picker.delegate = self
         picker.sourceType = .PhotoLibrary
         picker.allowsEditing = true*/
        self.actionSheet()
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
    
    func updateInfoFromDatabase(){
        
        DataService.dataService.userRef.queryOrderedByChild(currentUser).observeEventType(FEventType.ChildAdded, withBlock: { snapshot in
            
            print("The first name is \(snapshot.value["first"] as! String)")
            
            if  snapshot.value["first"] as! String == "" {
                self.firstName.text = snapshot.value["first"] as? String
            }
            else {
                self.firstName.placeholder = "Enter your first name."
            }
            /*  if  snapshot.value["last"] as! String != "" {
             self.lastName.text = snapshot.value["last"] as? String
             }
             else {
             self.lastName.placeholder = "Enter your last name."
             }
             if  snapshot.value["phone"] as! String != "" {
             self.phoneNumber.text = snapshot.value["phone"] as? String
             }
             else {
             self.phoneNumber.placeholder = "Enter your phone number."
             }
             if  snapshot.value["email"] as! String != "" {
             self.emailAddress.text = snapshot.value["first"] as? String
             }
             else {
             self.emailAddress.placeholder = "Enter your email address"
             }
             if  snapshot.value["image"] as! String != "" {
             let imageString = snapshot.value["image"] as? String
             self.profileImage.image = self.convertBase64StringToUImage(imageString!)
             }
             else {
             self.profileImage.image = UIImage(named: "male")
             }*/
        })
    }
    
    
}

extension ProfileViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        
        //self.convertToBase64String(profileImage.image!)
        
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        //self.savedImageAlert()
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    // MARK:- UIImagePickerControllerDelegate methods
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let imageToSave: UIImage = (info[UIImagePickerControllerOriginalImage] as? UIImage)!{
            profileImage.image = imageToSave
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func convertToBase64String(image: UIImage)-> String
    {
        var data: NSData = NSData()
        
        if let image = profileImage.image {
            data = UIImageJPEGRepresentation(image, 0.75)!
        }
        let base64String = data.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        return base64String
    }
    func convertBase64StringToUImage(baseString: String)-> UIImage {
        let decodedData = NSData(base64EncodedString: baseString, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
        let decodedimage = UIImage(data: decodedData!)
        //println(decodedimage)
        return decodedimage! as UIImage
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func actionSheet(){
        let alertController: UIAlertController = UIAlertController(title: "Master your selfie skill.", message: "Choose a photo where other people can recognize you easily. ", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let takePhoto = UIAlertAction(title: "Take a photo", style: UIAlertActionStyle.Default){(action)-> Void in
            self.takePhoto()
        }
        let chooosePhoto = UIAlertAction(title: "Choose a photo", style: UIAlertActionStyle.Default){(action)-> Void in
            self.choosePhoto()
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default){(action)-> Void in
            
        }
        alertController.addAction(takePhoto)
        alertController.addAction(chooosePhoto)
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    func takePhoto(){
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .Camera
        self.presentViewController(cameraPicker, animated: true, completion: nil)
        
    }
    
    func choosePhoto(){
        let photoPicker = UIImagePickerController()
        photoPicker.delegate = self
        photoPicker.sourceType = .PhotoLibrary
        self.presentViewController(photoPicker, animated: true, completion: nil)
        
    }
    
}