//
//  Trips.swift
//  Carpooling
//
//  Created by Sanjay Shrestha on 4/8/16.
//  Copyright © 2016 St Marys. All rights reserved.
//

import Foundation

class Trips{
    var driver:Rider?
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
    var capacity:NSInteger?
    var riders:[Rider]?
    
    init(rider:Rider, fromStreetAddress:String, fromCity:String, fromState:String, fromZipCode:String, toStreetAddress:String, toCity:String, toState:String, toZipCode:String, date:NSDate, time:NSCalendar, notes:String, capacity:NSInteger)
    {
        self.driver = rider
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
        self.capacity = capacity
        
        
    }
    func addRider(rider:Rider){
        self.riders?.append(rider)
    }
    
    static func makeDummyTrips()->[Trips]{
        let r1:Rider = Rider(firstName: "Rahul", lastName: "Murthy", phoneNumber: "8457023976", email: "ram11@stmarys-ca.edu", password: "12345678", picture: UIImage(named: "male")!)
        
        let r2:Rider = Rider(firstName: "Sanjay", lastName: "Shrestha", phoneNumber: "2345983459", email: "ss42@stmarys-ca.edu", password: "12345678", picture: UIImage(named: "male")!)
        let r3:Rider = Rider(firstName: "Bob", lastName: "Dole", phoneNumber: "2354366546", email: "bob@stmarys-ca.edu", password: "12345678",picture: UIImage(named: "male")!)
        let r4:Rider = Rider(firstName: "sdfsdf", lastName: "asdfasdf", phoneNumber: "0548680456", email: "sfdf@stmarys-ca.edu", password: "12345678", picture: UIImage(named: "male")!)
        
        let date = NSDate()
        let cal = NSCalendar.currentCalendar()
        
        let t1:Trips = Trips(rider: r1, fromStreetAddress: "start1", fromCity: "city1", fromState: "state1", fromZipCode: "z1", toStreetAddress: "end1", toCity: "city2", toState: "state2", toZipCode: "z2", date: date, time: cal, notes: "bring snacks", capacity: 4)
        t1.addRider(r2)
        t1.addRider(r3)
        t1.addRider(r4)
        
        let t2:Trips = Trips(rider: r2, fromStreetAddress: "start2", fromCity: "city2", fromState: "state2", fromZipCode: "z2", toStreetAddress: "end2", toCity: "city3", toState: "state4", toZipCode: "z4", date: date, time: cal, notes: "bring snacks", capacity: 3)
        
        t2.addRider(r1)
        t2.addRider(r4)
        
        let temp = [t1,t2]
        return temp
    }
    
    
    
    
}