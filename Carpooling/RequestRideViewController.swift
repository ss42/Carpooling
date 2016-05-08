//
//  RequestRideViewController.swift
//  Carpooling
//
//  Created by Sanjay Shrestha on 4/8/16.
//  Copyright © 2016 St Marys. All rights reserved.
//

import UIKit
import GoogleMaps


extension RequestRideViewController: GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWithPlace place: GMSPlace) {
        //searchController?.active = false
        // Do something with the selected place.
        if ((searchController?.active) != false)
        {
            searchController?.active = false
            print("Place name: ", place.name)
            print("Place address: ", place.formattedAddress)
            print("Place attributions: ", place.attributions)
            //self.fromStreetAddressTextField.text = place.addressComponents.["street_address"]
            
            var tempDict:[String:String?] = ["test":"place"]
            print("after dict declaration")
            
            for i in place.addressComponents!{
                print(i.type, " ", i.name)
            }
     
            
            for i in place.addressComponents!{
                print("before assignment")
                
                let temp = i.name as String!
                print(temp)
                print(i.type)
                if (temp != nil)
                {
                    tempDict[i.type] = temp
                }
                
                print("after assignment")
                print(i.type, " " , i.name)
            }
            if (tempDict["street_number"] != nil && tempDict["route"] != nil)
            {
                self.fromStreetAddressTextField.text = "\(tempDict["street_number"]!!) \(tempDict["route"]!!)"
            }
            
            if (tempDict["administrative_area_level_1"] != nil && tempDict["postal_code"] != nil && tempDict["locality"] != nil){
                self.fromCityTextField.text = tempDict["locality"]!!
                self.fromStateTextField.text = tempDict["administrative_area_level_1"]!!
                self.fromZipCode.text = tempDict["postal_code"]!!
            }
        }
        else
        {
            searchController2?.active = false
            print("Place name: ", place.name)
            print("Place address: ", place.formattedAddress)
            print("Place attributions: ", place.attributions)
            //self.fromStreetAddressTextField.text = place.addressComponents.["street_address"]
            
            var tempDict:[String:String?] = ["test":"place"]
            print("after dict declaration")
            
            for i in place.addressComponents!{
                print(i.type, " ", i.name)
            }
            
            
            for i in place.addressComponents!{
                print("before assignment")
                
                let temp = i.name as String!
                print(temp)
                print(i.type)
                if (temp != nil)
                {
                    tempDict[i.type] = temp
                }
                
                print("after assignment")
                print(i.type, " " , i.name)
            }
            if (tempDict["street_number"] != nil && tempDict["route"] != nil)
            {
                self.toStreetAddressTextField.text = "\(tempDict["street_number"]!!) \(tempDict["route"]!!)"
            }
            
            if (tempDict["administrative_area_level_1"] != nil && tempDict["postal_code"] != nil && tempDict["locality"] != nil){
                self.toCityTextfield.text = tempDict["locality"]!!
                self.toStateTextField.text = tempDict["administrative_area_level_1"]!!
                self.toZipCodeTextField.text = tempDict["postal_code"]!!
            }
        }
        
    }
    
    func resultsController(resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: NSError){
        // TODO: handle the error.
        print("Error: ", error.description)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictionsForResultsController(resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictionsForResultsController(resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
}



class RequestRideViewController: UIViewController {
    
    // adding stuff for autocomplete
    
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    
    var resultsViewController2: GMSAutocompleteResultsViewController?
    var searchController2: UISearchController?
    var resultView2: UITextView?
    
    

    
    
    
    @IBOutlet weak var searchView1: UIView!
    @IBOutlet weak var searchView2: UIView!

    @IBOutlet weak var notes: UITextView!

    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var fromStreetAddressTextField: UITextField!
    @IBOutlet weak var fromCityTextField: UITextField!
    @IBOutlet weak var fromStateTextField: UITextField!
    @IBOutlet weak var fromZipCode: UITextField!
    
    @IBOutlet weak var toStreetAddressTextField: UITextField!
    @IBOutlet weak var toCityTextfield: UITextField!
    @IBOutlet weak var toStateTextField: UITextField!
    @IBOutlet weak var toZipCodeTextField: UITextField!
    
    let tempRider = Rider(firstName: "john", lastName: "Snow", phoneNumber: "01154", email: "abcom", password: "hey", picture:  "male")
    //let tempTrip = Trips(tempRider)
    
    func custom(){
        searchController?.searchBar.placeholder = "Enter Address here"
        searchController?.searchBar.imageForSearchBarIcon(UISearchBarIcon.ResultsList, state: UIControlState.Normal)
        searchController?.searchBar.barTintColor = UIColor.redColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.custom()
        datePicker.hidden = true
        doneButton.hidden = true
        confirmTextFieldDelegate()
        
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        
        resultsViewController2 = GMSAutocompleteResultsViewController()
        resultsViewController2?.delegate = self
        
        
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        
        searchController2 = UISearchController(searchResultsController: resultsViewController2)
        searchController2?.searchResultsUpdater = resultsViewController2
        
        //let subView = UIView(frame: CGRectMake(0, 65.0, 350.0, 45.0))
        let subView = searchView1
        let controller1 = searchController?.searchBar
        controller1?.placeholder = "Enter your starting address here"
        
        subView.addSubview((controller1)!)
        self.view.addSubview(subView)
        searchController?.searchBar.sizeToFit()
        searchController?.hidesNavigationBarDuringPresentation = false
        
        let subView2 = searchView2
        let controller2 = searchController2?.searchBar
        controller2?.placeholder = "Enter your destiation address"
        subView2.addSubview(controller2!)
        self.view.addSubview(subView2)
        searchController2?.searchBar.sizeToFit()
        searchController2?.hidesNavigationBarDuringPresentation = false
        
        
        
        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        self.definesPresentationContext = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func confirmTextFieldDelegate() {
        fromStreetAddressTextField.delegate = self
        fromCityTextField.delegate = self
        fromStateTextField.delegate = self
        fromZipCode.delegate = self
        toStreetAddressTextField.delegate = self
        toCityTextfield.delegate = self
        toStateTextField.delegate = self
        toZipCodeTextField.delegate = self
    }
    
  
    
    @IBAction func chooseDateAndTimeTapped(sender: AnyObject) {
        datePicker.hidden = false
        doneButton.hidden = false
        notes.hidden = true
     
        //need to reload data
        
    }
  
    @IBAction func doneTapped(sender: AnyObject) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        let strDate = dateFormatter.stringFromDate(datePicker.date)
        dateLabel.text = strDate
        datePicker.hidden = true
        notes.hidden = false
    }
    
    //to display alert for errors
    func displayMyAlertMessage(title: String, message: String) {
        let myAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil);
    }
    
    func checkResponder(textField: UITextField){
        if textField.isFirstResponder(){
            textField.resignFirstResponder()
            print("dismiss respone")
        }
        else{
            textField.becomeFirstResponder()
            print("become first repsonder")
        }
    }
    
    
    @IBAction func submitTapped(sender: AnyObject) {
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

}

extension RequestRideViewController: UITextFieldDelegate{
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
