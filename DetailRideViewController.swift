//
//  DetailRideViewController.swift
//  Carpooling
//
//  Created by Sanjay Shrestha on 4/29/16.
//  Copyright © 2016 St Marys. All rights reserved.
//

import UIKit
import MessageUI


class DetailRideViewController: UIViewController{//, MFMessageComposeViewControllerDelegate{
    
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var fullNameLabel: UILabel!
    
    @IBOutlet weak var postedTimeLabel: UILabel!
    
    @IBOutlet weak var pickUpTimeLabel: UILabel!
    
    @IBOutlet weak var startAddressLabel: UILabel!
   
    @IBOutlet weak var endAddressLabel: UILabel!
    
    @IBOutlet weak var capacityLabel: UILabel!
    
    @IBOutlet weak var notesLabel: UILabel!
    
    @IBOutlet weak var addedRiders: UILabel!
    
    
    var phoneNumber = ""
    var rideDetail: Trips?
    var riderAddedAmount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadDataFromPreviousViewController()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        
        
        
    }

    
    @IBAction func updateCapacityStepper(sender: UIStepper) {
        let totalriders = (Int(rideDetail!.startingCapacity)! - Int(rideDetail!.capacity)!)
        print(totalriders)
        if (Int(rideDetail!.startingCapacity)! > totalriders){
            sender.maximumValue = Double(rideDetail!.capacity)!
        }
        else
        {
            sender.maximumValue = 0
        }
    //sender.maximumValue = Double(rideDetail!.capacity)!
    sender.minimumValue = 1
    let ridersAdded = Int(sender.value)
        self.riderAddedAmount = ridersAdded
        print(self.riderAddedAmount)
    
    
    
    capacityLabel.text =  "Seats remaining: \(totalriders + ridersAdded) / \(rideDetail!.startingCapacity)"
        print(riderAddedAmount)
    addedRiders.text = "(\((riderAddedAmount))+ person(s) added)"
        print(addedRiders.text)
    

    }
    
    

    
    @IBAction func sendMail(sender: AnyObject) {
        
        let contactAlertController = UIAlertController(title: "Contact  \((fullNameLabel.text)!)", message: ":)", preferredStyle: .ActionSheet )
        
        let callAction = UIAlertAction(title: "Call the Driver", style: UIAlertActionStyle.Default){(action)-> Void in
            print("THe number calling is tel://+1\((self.rideDetail?.phoneNumber)!)")
            
            let url:NSURL = NSURL(string: "tel://+1\((self.rideDetail?.phoneNumber)!)")!
            UIApplication.sharedApplication().openURL(url)
            //do stuff
        }
        let textAction = UIAlertAction(title: "Text", style: UIAlertActionStyle.Default){(action)-> Void in
            //do stuff
            
            let msgVC = MFMessageComposeViewController()
            msgVC.body = ""
            msgVC.recipients = [(self.rideDetail?.phoneNumber)!]
            msgVC.messageComposeDelegate = self
            self.presentViewController(msgVC, animated: true, completion: nil)
            
        }
        let emailAction = UIAlertAction(title: "Email", style: UIAlertActionStyle.Default){(action)-> Void in
            //self.performSegueWithIdentifier("sendMailSegue", sender: nil)
            //let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: SendMailViewController = self.storyboard!.instantiateViewControllerWithIdentifier("sendMail") as! SendMailViewController
            vc.emailAddress = self.rideDetail?.email
            self.presentViewController(vc, animated: true, completion: nil)
            
            //do stuff
            //segue to sendmailcontroller and send data or driver's email add thru segue
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default){(action)-> Void in
            
        }
        contactAlertController.addAction(callAction)
        contactAlertController.addAction(textAction)
        contactAlertController.addAction(emailAction)
        contactAlertController.addAction(cancelAction)
        
        self.presentViewController(contactAlertController, animated: true, completion: nil)

        
    }
    
    @IBAction func requestRidePressed(sender: AnyObject) {
        if self.riderAddedAmount != 0 {
            alert("You added \((riderAddedAmount)) persons to the ride!", msg: "Are you sure you want to request this Ride?", confirm: true)
        }
        else
        {
            alert("Alert", msg: "You have not added any riders to this ride. ", confirm: false)
        }
        
    }
    
    
    func alert(title: String, msg: String, confirm: Bool){
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
       
        if confirm{
            
            let confirm = UIAlertAction(title: "Confirm", style: .Default){(action)-> Void in
                let newCapacity = ["capacity": "\(Int((self.rideDetail?.capacity)!)! - self.riderAddedAmount)"]
                DataService.dataService.postRef.childByAppendingPath(self.rideDetail?.postId).updateChildValues(newCapacity)
                
                let vc: RideHistoryViewController = self.storyboard!.instantiateViewControllerWithIdentifier("myRide") as! RideHistoryViewController
                let requestedRide = self.rideDetail
                vc.myRideArray.addObject(requestedRide!)
                self.performSegueWithIdentifier("goHome", sender: nil)
                //do stuff
            }
            alertController.addAction(confirm)
           

        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil))

        presentViewController(alertController, animated: true, completion: nil)
        
    }
    

    func loadDataFromPreviousViewController(){
        self.image.image = UIImage(named: "male")
        self.fullNameLabel.text = "\(rideDetail!.firstName) \(rideDetail!.lastName)"
        self.postedTimeLabel.text = rideDetail?.postedTime
        self.pickUpTimeLabel.text = "I will pick you on \(rideDetail!.pickUpTime)"
        self.startAddressLabel.text = "From \(rideDetail!.fromStreetAddress), \(rideDetail!.fromCity), \(rideDetail!.fromState), \(rideDetail!.fromZipCode) "
        self.endAddressLabel.text = "To: \(rideDetail!.toStreetAddress), \(rideDetail!.toCity), \(rideDetail!.toState), \(rideDetail!.toZipCode)  "
        
        // capacity math
        let totalriders = (Int(rideDetail!.startingCapacity)! - Int(rideDetail!.capacity)!)
        print(totalriders)
        self.capacityLabel.text =  "Seats remaining: \(totalriders) / \(rideDetail!.startingCapacity)"
        self.notesLabel.text = "Notes from the Driver: \(rideDetail!.notes)"
        self.phoneNumber = (rideDetail?.driver?.phoneNumber)!
        
    }
    
    
}
extension DetailRideViewController: MFMessageComposeViewControllerDelegate{
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        self.dismissViewControllerAnimated(true, completion: nil)
        //tableView.reloadData()
        
        
    }
}
