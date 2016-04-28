//
//  Firebase.swift
//  Carpooling
//
//  Created by Sanjay Shrestha on 4/15/16.
//  Copyright © 2016 St Marys. All rights reserved.
//


import Foundation
import Firebase


let BASE_URL =  "http://smcpool.firebaseio.com"

class DataService {
    static let dataService = DataService()
    
    var baseRef = Firebase(url: "\(BASE_URL)")
    var userRef = Firebase(url: "\(BASE_URL)/users")
    var postRef = Firebase(url: "\(BASE_URL)/posts")
    
  
    
    var CURRENT_USER_REF: Firebase {
        let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
        
        let currentUser = Firebase(url: "\(baseRef)").childByAppendingPath("users").childByAppendingPath(userID)
        
        return currentUser!
    }
    
    
    func createNewAccount(uid: String, user: Dictionary<String, String>) {
        
        // A User is born.
        
        userRef.childByAppendingPath(uid).setValue(user)
    }
    
    func createNewPost(trip: Dictionary<String, AnyObject>) {
        
       
        
        let firebaseNewPost = postRef.childByAutoId()
        
        // setValue() saves to Firebase.
        
        firebaseNewPost.setValue(trip)
    }
}

//Firebase.defaultConfig().persistenceEnabled = true
//ref.keepSynced(true)