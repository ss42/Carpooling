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
  

    var currentUser = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.hidden = true
        doneButton.hidden = true
        confirmTextFieldDelegate()
        /**
        DataService.dataService.CURRENT_USER.observeEventType(FEventType.Value, withBlock: { snapshot in
            
            let currentUser = snapshot.value.objectForKey("email") as! String
            
            print("email: \(currentUser)")
            self.currentUser = currentUser
            }, withCancelBlock: { error in
                print(error.description)
        })**/
        
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
        
        //check for field if empty...
        
        
        print("Todays date is  \(postedTime)")
        let pickupTime = dateLabel.text
        
        let user: NSDictionary = ["fromStreet": fromStreet!, "fromCity": fromCity!, "fromState": fromState!,"fromZipCode": fromZipCode!, "toStreet": toStreet!, "toCity": toCity!, "toState": toState!, "toZipCode": toZipCode!, "postedTime" : postedTime, "pickupTime" : pickupTime!]
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
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        let currentTimeAndDate:String = dateFormatter.stringFromDate(todaysDate)
        return currentTimeAndDate
    }

}

extension CreateNewRideViewController: UITextFieldDelegate{
    func textFieldDidEndEditing(textField: UITextField) {
        print("test")
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
        print("tessdft")
        return true
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}