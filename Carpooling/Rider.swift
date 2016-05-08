//
//  Rider.swift
//  Carpooling
//
//  Created by Sanjay Shrestha on 4/8/16.
//  Copyright © 2016 St Marys. All rights reserved.
//

import Foundation
import Firebase

class Rider{
    
    var firstName = ""
    var lastName = ""
    var phoneNumber = ""
    var email = ""
    var password = ""
    var picture = ""
    //let uid: String
    
    // Initialize from Firebase(test)
    init(authData: FAuthData) {
      //  uid = authData.uid
        email = authData.providerData["email"] as! String
        password = authData.providerData["provider"] as! String
    }
    init(uidAddress: String)
    {
        //self.uid = uidAddress
    }
    
    init(firstName:String, lastName:String, phoneNumber:String, email:String, password:String, picture: String)//, uid: String)
    {
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.email = email
        self.password = password
        self.picture = picture
       // self.uid = uid
    }
    
}