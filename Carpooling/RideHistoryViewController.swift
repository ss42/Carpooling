//
//  RideHistoryViewController.swift
//  Carpooling
//
//  Created by Sanjay Shrestha on 5/11/16.
//  Copyright © 2016 St Marys. All rights reserved.
//

import UIKit

class RideHistoryViewController: UIViewController {
    
    var myRideArray: NSMutableArray = []

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.reloadData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension RideHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return myRideArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: AvailableRidesTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! AvailableRidesTableViewCell
        
       
            let trip = myRideArray[indexPath.row] as! Trips
            // Configure the cell...
            // let picture = convertBase64StringToUImage((trip.driver?.picture)!)
            
            cell.fullName.text = "\(trip.firstName) \(trip.lastName)"
            // cell.picture.image = picture
            cell.startAddress?.text = "Leaving \(trip.fromCity) to \(trip.toCity) \n on  \(trip.pickUpTime)  "
            // cell.endAddress?.text = "To: \(trip.toStreetAddress), \(trip.toCity), \(trip.toState), \(trip.toZipCode)  "
            cell.postedTime?.text = "Posted \(trip.postedTime)"
            cell.pickUpTime?.text = "On \(trip.pickUpTime)"
            //   cell.notes?.text = "Notes here \(trip.notes)"
            cell.capacity?.text = "Capacity: \(trip.capacity)"
 

        
        return cell
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //go to detail view
    }
}