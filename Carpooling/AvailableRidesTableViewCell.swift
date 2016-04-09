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
    
    @IBOutlet weak var endAddress: UILabel!
    
    @IBOutlet weak var postedTime: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var picture: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
