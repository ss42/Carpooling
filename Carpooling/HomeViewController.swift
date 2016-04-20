//
//  HomeViewController.swift
//  Carpooling
//
//  Created by Sanjay Shrestha on 4/1/16.
//  Copyright © 2016 St Marys. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var open: UIBarButtonItem!
    
    @IBOutlet weak var tableView: UITableView!
    
    var tempArray:NSMutableArray = [] //Trips.makeDummyTrips()
    //var tempArray:NSMutableArray?
    
    var dummy = [["hello world" , "male"]]
    
    
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
            let notes = "hello"
            print("Posted time is   \(pickUpTime) in fetch trip function ")
   

            
            
            print("Posted time is   \(postedTime) in fetch trip function ")

            let r5:Rider = Rider(firstName: "Rahul3", lastName: "Murthy2", phoneNumber: "8457023976", email: "ram11@stmarys-ca.edu", password: "12345678", picture: UIImage(named: "male")!)
            
            
            self.tempArray.addObject(Trips(rider: r5, fromStreetAddress: fromStreet!, fromCity: fromCity!, fromState: fromState!, fromZipCode: fromZipCode!, toStreetAddress: toStreet!, toCity: toCity!, toState: toState!, toZipCode: toZipCode!, pickUpTime: pickUpTime! , notes: notes, postedTime: postedTime!, capacity: 5))
            
            print(self.tempArray.count)
            self.tableView.reloadData()
        })
        print("temp array count is:  \(tempArray.count)")
        
    }
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTripList()
        print("after fetch")

        tableView.delegate = self
        tableView.dataSource = self
        
        
        if self.revealViewController() != nil {
           open.target = self.revealViewController()
            open.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        print("viewdid load")
        self.tableView.reloadData()
        
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func timeElapsed(date: String)-> String{
        let dateformatter = NSDateFormatter()
        dateformatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateformatter.dateFormat = "h:mm a"
        let postedDate  = dateformatter.dateFromString(date)!
        
        print("Posted time is is  \(date)")

        print("Posted time is is  \(postedDate)")

        let elapsedTimeInSeconds = NSDate().timeIntervalSinceDate(postedDate)
        let secondInDays: NSTimeInterval = 60 * 60 * 24
        if elapsedTimeInSeconds > 7 * secondInDays {
            dateformatter.dateFormat = "MM/dd/yy"
        } else if elapsedTimeInSeconds > 7 * secondInDays{
            dateformatter.dateFormat = "EEE"
        } else if elapsedTimeInSeconds > secondInDays/24{
            dateformatter.dateFormat = "HH"
            
        }
        let timeToShow: String = dateformatter.stringFromDate(postedDate)
        return timeToShow
    }
    
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
        

        cell.picture.image = UIImage(named: "male")
        cell.startAddress?.text = "\(trip.fromStreetAddress), \(trip.fromCity), \(trip.fromState), \(trip.toZipCode))  "
        cell.endAddress?.text = "\(trip.toStreetAddress), \(trip.toCity), \(trip.toState), \(trip.toZipCode))  "
        cell.postedTime?.text = trip.postedTime
        cell.pickUpTime?.text = "Pick Up at \(trip.pickUpTime)"
     

        configureTableView()
        
        return cell
    }
    func configureTableView(){
        tableView.rowHeight = 200.00
        
        
    }
    
}

