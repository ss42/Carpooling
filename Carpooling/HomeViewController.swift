//
//  HomeViewController.swift
//  Carpooling
//
//  Created by Sanjay Shrestha on 4/1/16.
//  Copyright © 2016 St Marys. All rights reserved.
//

import UIKit
import Firebase
import MessageUI


class HomeViewController: UIViewController{
    
    
    @IBOutlet weak var open: UIBarButtonItem!
    
    @IBOutlet weak var tableView: UITableView!
    
    var tempArray:NSMutableArray = [] //Trips.makeDummyTrips()
    //var tempArray:NSMutableArray?
    
    var imageToSend : UIImage?
    
    // fetch the trips from firebase and then update the tempArray
    func fetchTripList()
    {
        
        DataService.dataService.postRef.queryOrderedByKey().observeEventType(.ChildAdded, withBlock: {
            snapshot in
            
            let fromStreet = snapshot.value["fromStreet"] as? String
            let fromCity = snapshot.value["fromCity"] as? String
            let fromState = snapshot.value["fromState"] as? String
            let fromZipCode = snapshot.value["fromZipCode"] as? String
            let toStreet = snapshot.value["toStreet"] as? String
            let toCity = snapshot.value["toCity"] as? String
            let toState = snapshot.value["toState"] as? String
            let toZipCode = snapshot.value["toZipCode"] as? String
            let postedTime = snapshot.value["postedTime"] as? String
            let pickUpTime = snapshot.value["pickupTime"] as? String
            let notes = snapshot.value["notes"] as? String
            let capacity = snapshot.value["capacity"] as? String
            let elapsed = self.timeElapsed(postedTime!)
            let firstName = snapshot.value["first"] as? String
            let lastName = snapshot.value["last"] as? String
            let phoneNumber = snapshot.value["phone"] as? String
            let email = snapshot.value["email"] as? String
            //let picture = snapshot.value["image"] as? String
            let picture = "male"
            

            
            let r5: Rider = Rider(firstName: firstName!, lastName: lastName!, phoneNumber: phoneNumber!, email: email!, password: "39874", picture: picture)
            
            self.tempArray.addObject(Trips(rider: r5, fromStreetAddress: fromStreet!, fromCity: fromCity!, fromState: fromState!, fromZipCode: fromZipCode!, toStreetAddress: toStreet!, toCity: toCity!, toState: toState!, toZipCode: toZipCode!, pickUpTime: pickUpTime! , notes: notes!, postedTime: elapsed, capacity: capacity!))
            
            
            print(self.tempArray.count)
            self.tableView.reloadData()
        })
        print("temp array count is:  \(tempArray.count)")
        
        
    }
    func convertBase64StringToUImage(baseString: String)-> UIImage {
        let decodedData = NSData(base64EncodedString: baseString, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
        let decodedimage = UIImage(data: decodedData!)
        //println(decodedimage)
        return decodedimage! as UIImage
        
    }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchTripList()
       
        tableView.delegate = self
        tableView.dataSource = self
        
        if self.revealViewController() != nil {
           open.target = self.revealViewController()
            open.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        self.tableView.reloadData()
  
        
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Calculates the time elapsed after a given time
    func timeElapsed(date: String)-> String{
        let dateformatter = NSDateFormatter()
        dateformatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let postedDate  = dateformatter.dateFromString(date)!
       // print("posted date is  \(postedDate)")


        let elapsedTimeInSeconds = NSDate().timeIntervalSinceDate(postedDate)
       // print("Elapsed Time in Second  is  \(elapsedTimeInSeconds)")

        
        let secondInDays: NSTimeInterval = 60 * 60 * 24
       // print("Seconds in days is  \(secondInDays)")

        
        if elapsedTimeInSeconds > 7 * secondInDays {
            dateformatter.dateFormat = "MM/dd/yy"
         //   print("first if statement Time Elapsed")
            let timeToShow: String = dateformatter.stringFromDate(postedDate)
            return timeToShow

        } else if elapsedTimeInSeconds > secondInDays{
            dateformatter.dateFormat = "EEE"
           // print("first if statement Time Elapsed > secinds indays ")
            let timeToShow: String = dateformatter.stringFromDate(postedDate)
            return timeToShow


        } else if elapsedTimeInSeconds > secondInDays/60{
            let timeToshow = Int(elapsedTimeInSeconds/3600)

            return "\(timeToshow) hour ago"

        }
        else {
            let timeToshow = Int(elapsedTimeInSeconds/60)
            return "\(timeToshow) mins ago "
        }
    
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetailsSegue"{
            let indexPath: NSIndexPath = self.tableView.indexPathForSelectedRow!

          let destinationVC = segue.destinationViewController as! DetailRideViewController
            destinationVC.rideDetail = tempArray[indexPath.row] as? Trips
            //vc.detailTrips = tempArray[indexPath.row] as! NSMutableArray
        }
        else if segue.identifier == "sendMailSegue"
        {
            let vc = segue.destinationViewController as! SendMailViewController
            presentViewController(vc, animated: true, completion: nil)
        }
    }
    
    /*
        else if segue.identifier == "GoogleMapViewToUserProfileView" {
            self.screenShotMethod()
            (segue.destinationViewController as! UserProfileViewController).userProfileViewBackgroundImage = self.userProfileViewBackgroundImage
        }
        else if segue.identifier == "awaitingConfirmView"{
            self.screenShotMethod()
            
            (segue.destinationViewController as! AwaitingConfirmationViewController).userProfileViewBackgroundImage = self.userProfileViewBackgroundImage
            
        }
    }
    */
}
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: AvailableRidesTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! AvailableRidesTableViewCell
        
        let trip = tempArray[indexPath.row] as! Trips
        
        // Configure the cell...
       // let picture = convertBase64StringToUImage((trip.driver?.picture)!)
        
        cell.fullName.text = "\(trip.firstName) \(trip.lastName)"
       // cell.picture.image = picture
        cell.startAddress?.text = "From: \(trip.fromStreetAddress), \(trip.fromCity), \(trip.fromState), \(trip.fromZipCode)  "
        cell.endAddress?.text = "To: \(trip.toStreetAddress), \(trip.toCity), \(trip.toState), \(trip.toZipCode)  "
        cell.postedTime?.text = "Posted \(trip.postedTime)"
        cell.pickUpTime?.text = "On \(trip.pickUpTime)"
        cell.notes?.text = "Notes here \(trip.notes)"
        print("Trip Notes 66666 is \(trip.notes)")
        cell.capacity?.text = "Capacity: \(trip.capacity)"
        
        configureTableView()
        
        return cell
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //when selected do something
      //  let requestedRide = self.tempArray[indexPath.row] as! Trips
       // let sendImage: UIImage = requestedRide.

        self.performSegueWithIdentifier("showDetailsSegue", sender: nil)
        
        
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let requestedRide = self.tempArray[indexPath.row] as! Trips
        let driver = "\(requestedRide.driver!.firstName) \(requestedRide.driver!.lastName)"
        
        let contactAction = UITableViewRowAction(style: .Normal, title: "Contact \(requestedRide.driver!.firstName)"){(action: UITableViewRowAction!, indexPath: NSIndexPath) -> Void in
            
            let contactAlertController = UIAlertController(title: "Contact  \(driver)", message: ":)", preferredStyle: .ActionSheet )
            
            let callAction = UIAlertAction(title: "Call the Driver", style: UIAlertActionStyle.Default){(action)-> Void in
                    //do stuff
            }
            let textAction = UIAlertAction(title: "Text", style: UIAlertActionStyle.Default){(action)-> Void in
                    //do stuff
            }
            let emailAction = UIAlertAction(title: "Email", style: UIAlertActionStyle.Default){(action)-> Void in
                self.performSegueWithIdentifier("sendMailSegue", sender: nil)
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
        
        contactAction.backgroundColor = UIColor.blackColor()
    
        return [contactAction]
    }
    
    
    
    func configureTableView(){
        tableView.rowHeight = 160.00
        
        
    }
}



