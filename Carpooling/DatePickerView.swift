//
//  DatePickerView.swift
//  Carpooling
//
//  Created by Sanjay Shrestha on 5/7/16.
//  Copyright © 2016 St Marys. All rights reserved.
//

import UIKit

protocol DatePickerViewDelegate {
    func cancelPressed()
    func donePressed()
}

class DatePickerView: UIView {
    var delegate: DatePickerViewDelegate?

    @IBOutlet weak var datePicker: UIDatePicker!
    
    var date: String?
    
    
    @IBAction func cancelPressed(sender: AnyObject) {
        delegate?.cancelPressed()
    }
    

    @IBAction func donePressed(sender: AnyObject) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.dateFormat = "dd MMM HH:mm"
        let strDate = dateFormatter.stringFromDate(self.datePicker.date)
        date = strDate
        delegate?.donePressed()

    }
}
