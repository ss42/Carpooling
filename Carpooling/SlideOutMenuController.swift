//
//  SlideOutMenuController.swift
//  Carpooling
//
//  Created by Sanjay Shrestha on 4/2/16.
//  Copyright © 2016 St Marys. All rights reserved.
//

import UIKit

class SlideOutMenuController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .None
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
