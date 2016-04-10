//
//  Rider.swift
//  Carpooling
//
//  Created by Sanjay Shrestha on 4/8/16.
//  Copyright © 2016 St Marys. All rights reserved.
//

import Foundation

class Rider{
    
    var firstName = ""
    var lastName = ""
    var phoneNumber = ""
    var email = ""
    var password = ""
    var picture: UIImage?
    
    init(firstName:String, lastName:String, phoneNumber:String, email:String, password:String, picture: UIImage)
    {
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.email = email
        self.password = password
        self.picture = picture
    }
    
}