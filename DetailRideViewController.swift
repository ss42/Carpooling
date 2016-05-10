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
    
    @IBOutlet weak var message: UITextView!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var fullNameLabel: UILabel!
    
    @IBOutlet weak var postedTimeLabel: UILabel!
    
    @IBOutlet weak var pickUpTimeLabel: UILabel!
    
    @IBOutlet weak var startAddressLabel: UILabel!
   
    @IBOutlet weak var endAddressLabel: UILabel!
    
    @IBOutlet weak var capacityLabel: UILabel!
    
    @IBOutlet weak var notesLabel: UILabel!
    
    
    
    
    var phoneNumber = ""
    var rideDetail: Trips?
    
    
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
    
    
    
    capacityLabel.text =  "Seats remaining: \(totalriders + ridersAdded) / \(rideDetail!.startingCapacity)"

    }
    
    
    
    @IBAction func sendMessage(sender: AnyObject) {
        /*
        let msgVC = MFMessageComposeViewController()
        msgVC.body = "body here"
        msgVC.recipients = [phoneNumber]
        
        msgVC.messageComposeDelegate = self
        
        self.presentViewController(msgVC, animated: true, completion: nil)
        
        */
        
    }
    
    
    @IBAction func sendMail(sender: AnyObject) {
        
        
    }
    
    
    
    @IBAction func call(sender: AnyObject) {
        
        if let phoneURL = NSURL(string: "tel://\(phoneNumber)"){
            UIApplication.sharedApplication().openURL(phoneURL)
        }
        
        
    }
    func loadDataFromPreviousViewController(){
        image.image = UIImage(named: "male")
        fullNameLabel.text = "\(rideDetail!.firstName) \(rideDetail!.lastName)"
        postedTimeLabel.text = rideDetail?.postedTime
        pickUpTimeLabel.text = "I will pick you on \(rideDetail!.pickUpTime)"
        startAddressLabel.text = "From \(rideDetail!.fromStreetAddress), \(rideDetail!.fromCity), \(rideDetail!.fromState), \(rideDetail!.fromZipCode) "
        endAddressLabel.text = "To: \(rideDetail!.toStreetAddress), \(rideDetail!.toCity), \(rideDetail!.toState), \(rideDetail!.toZipCode)  "
        
        // capacity math
        let totalriders = (Int(rideDetail!.startingCapacity)! - Int(rideDetail!.capacity)!)
        print(totalriders)
        capacityLabel.text =  "Seats remaining: \(Int(rideDetail!.capacity)!) / \(rideDetail!.startingCapacity)"
        notesLabel.text = rideDetail!.notes
        phoneNumber = (rideDetail?.driver?.phoneNumber)!
        
    }
    
    
}
