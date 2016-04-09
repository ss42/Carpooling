//
//  Trips.swift
//  Carpooling
//
//  Created by Sanjay Shrestha on 4/8/16.
//  Copyright © 2016 St Marys. All rights reserved.
//

import Foundation

class Trips{
    
    var firstName = ""
    var lastName = ""
    var phoneNumber = ""
    var email = ""
    var fromStreetAddress = ""
    var fromCity = ""
    var fromState = ""
    var fromZipCode = ""
    var toStreetAddress = ""
    var toCity = ""
    var toState = ""
    var toZipCode = ""
    var date:NSDate?
    var hour:NSDateComponents?
    var minute:NSDateComponents?
    var calender:NSCalendar?
    var notes = ""
    
    init(rider:Rider, fromStreetAddress:String, fromCity:String, fromState:String, fromZipCode:String, toStreetAddress:String, toCity:String, toState:String, toZipCode:String, date:NSDate, time:NSCalendar, notes:String)
    {
        self.firstName = rider.firstName
        self.lastName = rider.lastName
        self.phoneNumber = rider.phoneNumber
        self.email = rider.email
        self.fromCity = fromCity
        self.fromState = fromState
        self.fromZipCode = fromZipCode
        self.toStreetAddress = toStreetAddress
        self.toCity = toCity
        self.toState = toState
        self.toZipCode = toZipCode
        self.date = date
        self.calender = NSCalendar.currentCalendar()
        let date = NSDate()
        //let calendar = NSCalendar.currentCalendar()
        //let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: date)
        let hour = self.calender!.components(NSCalendarUnit.Hour, fromDate: date)
        let minute = self.calender!.components(NSCalendarUnit.Minute, fromDate: date)
        self.hour = hour
        self.minute = minute
        
    }
    
    
    
    
}