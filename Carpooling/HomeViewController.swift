//
//  HomeViewController.swift
//  Carpooling
//
//  Created by Sanjay Shrestha on 4/1/16.
//  Copyright © 2016 St Marys. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var open: UIBarButtonItem!
    
    @IBOutlet weak var tableView: UITableView!
    
    var tempArray = Trips.makeDummyTrips()
    
    var dummy = [["hello world" , "male"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        if self.revealViewController() != nil {
           open.target = self.revealViewController()
            open.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        print("viewdid load")
    }
    
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
        
        //let photo = photos[indexPath.row]
        let trip = tempArray[indexPath.row]
        
        // Configure the cell...
        
        //cell.textLabel?.text = photo.caption
        cell.startAddress?.text = trip.toStreetAddress
        //cell.imageView?.image = UIImage(named: photo.thumbnailImageName)
        cell.picture.image = UIImage(named: "male")
        print("cell configured")
        configureTableView()
        
        return cell
    }
    func configureTableView(){
        //tableView.rowHeight = UITableViewAutomaticDimension
        tableView.rowHeight = 100.00
        
    }
    
}
