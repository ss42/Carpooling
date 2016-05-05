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
    var pickUpTime = ""
    var notes = ""
    var postedTime = ""
    var capacity = ""
    var riders:[Rider]?
    
    init(rider:Rider, fromStreetAddress:String, fromCity:String, fromState:String, fromZipCode:String, toStreetAddress:String, toCity:String, toState:String, toZipCode:String, pickUpTime: String, notes:String, postedTime: String, capacity: String)
    {
        self.driver = rider
        self.firstName = rider.firstName
        self.lastName = rider.lastName
        self.phoneNumber = rider.phoneNumber
        self.email = rider.email
        self.fromStreetAddress = fromStreetAddress
        self.fromCity = fromCity
        self.fromState = fromState
        self.fromZipCode = fromZipCode
        self.toStreetAddress = toStreetAddress
        self.toCity = toCity
        self.toState = toState
        self.toZipCode = toZipCode
        self.postedTime = postedTime
        self.pickUpTime = pickUpTime
        self.capacity = capacity
        self.notes = notes
        
    }
    
    func addRider(rider:Rider){
        self.riders?.append(rider)
    }
}