//
//  CreateNewRideViewController.swift
//  Carpooling
//
//  Created by Sanjay Shrestha on 4/10/16.
//  Copyright © 2016 St Marys. All rights reserved.
//

import UIKit
import GoogleMaps
import Firebase

class CreateNewRideViewController: UIViewController {

    
    @IBOutlet weak var notes: UITextView!
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var fromStreetAddressTextField: UITextField!
    @IBOutlet weak var fromCityTextField: UITextField!
    @IBOutlet weak var fromStateTextField: UITextField!
    @IBOutlet weak var fromZipCodeTextField: UITextField!
    
    @IBOutlet weak var toStreetAddressTextField: UITextField!
    @IBOutlet weak var toCityTextfield: UITextField!
    @IBOutlet weak var toStateTextField: UITextField!
    @IBOutlet weak var toZipCodeTextField: UITextField!
  
    @IBOutlet weak var capacity: UILabel!

    var currentUserUID = ""
    
    var user : NSDictionary?
    
var tempArray:NSMutableArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.hidden = true
        doneButton.hidden = true
        confirmTextFieldDelegate()
        DataService.dataService.userRef.observeAuthEventWithBlock({
            authData in
            print("hello world")
            if authData != nil{
                self.currentUserUID = authData.uid
                print("The UID for current user is \(self.currentUserUID)")
                self.updateInfoFromDatabase()
            }
            else
            {
                print("authdata is nil")
            }
        })
       
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
        
    func confirmTextFieldDelegate() {
        fromStreetAddressTextField.delegate = self
        fromCityTextField.delegate = self
        fromStateTextField.delegate = self
        fromZipCodeTextField.delegate = self
        toStreetAddressTextField.delegate = self
        toCityTextfield.delegate = self
        toStateTextField.delegate = self
        toZipCodeTextField.delegate = self
    }
    
    
    @IBAction func chooseDateAndTimeTapped(sender: AnyObject) {
        datePicker.hidden = false
        doneButton.hidden = false
        notes.hidden = true
        //self.datePicker.addGestureRecognizer(sender as! UIGestureRecognizer)
        
        //need to reload data
        
        
    }
    

    @IBAction func capacityStepperTapped(sender: UIStepper) {
        self.capacity.text = String(Int(sender.value))
    }
    
    
    
    @IBAction func submitTapped(sender: AnyObject) {
        
        
        let fromStreet = fromStreetAddressTextField.text
        let fromCity = fromCityTextField.text
        let fromState = fromStateTextField.text
        let fromZipCode = fromZipCodeTextField.text
        let toStreet = toStreetAddressTextField.text
        let toCity = toCityTextfield.text
        let toState = toStateTextField.text
        let toZipCode = toZipCodeTextField.text
        let postedTime = getCurrentTime()
        let numberOfSeat = capacity.text
        let notesFromDriver = notes.text
        //check for field if empty...
        let first = tempArray[0]
        let last = tempArray[1]
        let phone = tempArray[2]
        let email = tempArray[3]
        let imageString = tempArray[4]
        
        print("Todays date is  \(postedTime)")
        let pickupTime = dateLabel.text
        
        user = ["first": first, "last": last, "phone": phone, "email": email, "image": imageString,"fromStreet": fromStreet!, "fromCity": fromCity!, "fromState": fromState!,"fromZipCode": fromZipCode!, "toStreet": toStreet!, "toCity": toCity!, "toState": toState!, "toZipCode": toZipCode!, "postedTime" : postedTime, "pickupTime" : pickupTime!, "capacity": numberOfSeat!, "notes": notesFromDriver!]
        DataService.dataService.createNewPost(user as! Dictionary<String, AnyObject>)
        
       
        
        //to go to home screen
        performCustomSegue()
        
    }
    
    
    @IBAction func cancelTapped(sender: AnyObject) {
        performCustomSegue()
    }
    
    func performCustomSegue(){
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
     let vc: UIViewController = storyboard.instantiateViewControllerWithIdentifier("home")
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func doneTapped(sender: AnyObject) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.dateFormat = "dd MMM HH:mm"
        let strDate = dateFormatter.stringFromDate(datePicker.date)
        dateLabel.text = strDate
        datePicker.hidden = true
        notes.hidden = false
        doneButton.hidden = true
    }
    
    //to display alert for errors
    func displayMyAlertMessage(title: String, message: String) {
        let myAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil);
    }
    
    
    //may be we don't need the following function
    //to change responder for each textfield
    func changeResponder(textField: UITextField){
        if textField.isFirstResponder(){
            textField.resignFirstResponder()
            print("dismiss respone")
        }
        else{
            textField.becomeFirstResponder()
            print("become first repsonder")
        }
    }
    
    func getCurrentTime()-> String{
        let todaysDate:NSDate = NSDate()
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentTimeAndDate:String = dateFormatter.stringFromDate(todaysDate)
        return currentTimeAndDate
    }
    
    func updateInfoFromDatabase(){
        let newRef = Firebase(url: "http://smcpool.firebaseio.com/users/\(currentUserUID)")
        newRef.queryOrderedByKey().observeEventType(.Value, withBlock: {
            snapshot in
            
            print("Inside update from database func")
            let first = snapshot.value["first"] as? String
            let last = snapshot.value["last"] as? String
            let phone = snapshot.value["phone"] as? String
            let email = snapshot.value["email"] as? String
            let imageString = snapshot.value["image"] as? String
            
            print("The first name of this guy is \(first)")
            print("The last name of this guy is \(last)")
            print("The phone number of this guy is \(phone)")
            print("The email of this guy is \(email)")
            print("image not empty")
            print(imageString)
            
            if  (first != nil && last != nil && phone != nil && email != nil && imageString != nil) {
               
                    print("The first name of this guy is \(first)")
                    print("The last name of this guy is \(last)")
                    print("The phone number of this guy is \(phone)")
                    print("The email of this guy is \(email)")
                    print("image not empty")
                    print(imageString)
                  //  self.user = ["first": first!, "last": last!, "phone": phone!, "email": email!, "image": imageString!]
                print("User info sucessfully appended to dictionary ")
                self.tempArray.addObject(first!)
                self.tempArray.addObject(last!)
                self.tempArray.addObject(phone!)
                self.tempArray.addObject(email!)
                self.tempArray.addObject(imageString!)
                
                for i in self.tempArray{
                    print(i)
                }
    
        
             }
            else {
                //show profile is not completed to create ride
                self.showError()
                
                
            }
            
        })
    }
    func showError(){
        let alert = UIAlertController(title: "Missing Information", message: "Please complete your profile so that riders can get information to communicate with you", preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        //self.presentViewController(alert, animated: true, completion: nil)
        self.performSegueWithIdentifier("incompleteProfileSegue", sender: nil)
        self.presentViewController(alert, animated: true, completion: nil)

    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //let indexPath: NSIndexPath = self.tableView.indexPathForSelectedRow!
        if segue.identifier == "incompleteProfileSegue"{
            print("overide prepere for segue")
            let vc = segue.destinationViewController as! ProfileViewController
            self.presentViewController(vc, animated: true, completion: nil)
                    }
    }

}

extension CreateNewRideViewController: UITextFieldDelegate{
    func textFieldDidEndEditing(textField: UITextField) {
        //add something may be?
        
    }
    func textFieldShouldClear(textField: UITextField) -> Bool {
        return true
    }
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        return true
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return true
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}