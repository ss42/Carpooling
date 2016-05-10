//
//  AvailableRidesTableViewCell.swift
//  Carpooling
//
//  Created by Sanjay Shrestha on 4/9/16.
//  Copyright © 2016 St Marys. All rights reserved.
//

import UIKit

class AvailableRidesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var startAddress: UILabel!
    

    
    @IBOutlet weak var postedTime: UILabel!
    
    @IBOutlet weak var pickUpTime: UILabel!
    
    @IBOutlet weak var capacity: UILabel!
    
    @IBOutlet weak var picture: UIImageView!
    
 
    
    @IBOutlet weak var fullName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
