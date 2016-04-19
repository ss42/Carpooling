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
        print ("before data call to firebase")
        DataService.dataService.postRef.queryOrderedByKey().observeEventType(.ChildAdded, withBlock: {
            snapshot in
            
            print("after snapshot")
            let fromStreet = snapshot.value["fromStreet"] as? String
            print("from street: \(fromStreet)")
            let fromCity = snapshot.value["fromCity"] as? String
            let fromState = snapshot.value["fromState"] as? String
            let fromZipCode = snapshot.value["fromZipCode"] as? String
            let toStreet = snapshot.value["toStreet"] as? String
            let toCity = snapshot.value["toCity"] as? String
            let toState = snapshot.value["toState"] as? String
            let toZipCode = snapshot.value["toZipCode"] as? String
            let postedTime = snapshot.value["postedTime"] as? String
            
            print ("after city stuff")
            let r5:Rider = Rider(firstName: "Rahul3", lastName: "Murthy2", phoneNumber: "8457023976", email: "ram11@stmarys-ca.edu", password: "12345678", picture: UIImage(named: "male")!)
            print("after temp rider")
            print(snapshot.value["fromStreet"] as? String)
            
            self.tempArray.addObject(Trips(rider: r5, fromStreetAddress: fromStreet!, fromCity: fromCity!, fromState: fromState!, fromZipCode: fromZipCode!, toStreetAddress: toStreet!, toCity: toCity!, toState: toState!, toZipCode: toZipCode!, date: NSDate(), time: NSCalendar.currentCalendar(), notes: "",postedTime: postedTime!, capacity: 5))
            print("fromcity \(fromCity)")
            print(self.tempArray.count)
            self.tableView.reloadData()
        })
        print("temp array count is:  \(tempArray.count)")
        
    }
    
    /*func createTripFromFirebase(snapshot:FDataSnapshot){
        let r5:Rider = Rider(firstName: "Rahul3", lastName: "Murthy2", phoneNumber: "8457023976", email: "ram11@stmarys-ca.edu", password: "12345678", picture: UIImage(named: "male")!)
        
        tempArray.append(Trips(rider: r5, fromStreetAddress: "", fromCity: snapshot.value["fromCity"], fromState: snapshot.value["fromState"], fromZipCode: "", toStreetAddress: "", toCity: snapshot.value["toCity"], toState: snapshot.value["toState"], toZipCode: "", date: NSDate(), time: NSCalendar.currentCalendar(), notes: "", capacity: 5))
    }*/
    
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
    /*override func viewWillAppear(animated: Bool) {
        fetchTripList()
        tableView.reloadData()
    }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // make dummy riders and dummy trips
    
    /*let r1:Rider = Rider(firstName: "Rahul", lastName: "Murthy", phoneNumber: "8457023976", email: "ram11@stmarys-ca.edu", password: "12345678", picture: UIImage(named:"male")!)
    
    let r2:Rider = Rider(firstName: "Sanjay", lastName: "Shrestha", phoneNumber: "2345983459", email: "ss42@stmarys-ca.edu", password: "12345678", picture: UIImage(named:"male")!)
    let r3:Rider = Rider(firstName: "Bob", lastName: "Dole", phoneNumber: "2354366546", email: "bob@stmarys-ca.edu", password: "12345678", picture: UIImage(named:"male")!)
    let r4:Rider = Rider(firstName: "sdfsdf", lastName: "asdfasdf", phoneNumber: "0548680456", email: "sfdf@stmarys-ca.edu", password: "12345678", picture: UIImage(named:"male")!)
    
    let date = NSDate()
    let cal = NSCalendar.currentCalendar()
    
    let t1:Trips = Trips(rider: r1, fromStreetAddress: "start1", fromCity: "city1", fromState: "state1", fromZipCode: "z1", toStreetAddress: "end1", toCity: "city2", toState: "state2", toZipCode: "z2", date: date, time: cal, notes: "bring snacks", capacity: 4)
 */
    
    
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("in one of the table view functions")
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
        print("from street address")
        print(trip.fromStreetAddress)
        print("The Start Address is  ")
        print(cell.startAddress?.text)
        print("The end Address is  ")
        print(cell.endAddress?.text)

        configureTableView()
        
        return cell
    }
    func configureTableView(){
        tableView.rowHeight = 200.00
        
        
    }
    
}

