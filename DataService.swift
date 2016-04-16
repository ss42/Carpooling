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
    
    private var _BASE_REF = Firebase(url: "\(BASE_URL)")
    private var _USER_REF = Firebase(url: "\(BASE_URL)/users")
    private var _POST_REF = Firebase(url: "\(BASE_URL)/posts")
    
    var BASE_REF: Firebase {
        return _BASE_REF
    }
    
    var USER_REF: Firebase {
        return _USER_REF
    }
    var JOKE_REF: Firebase {
        return _POST_REF
    }
    
    var CURRENT_USER_REF: Firebase {
        let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
        
        let currentUser = Firebase(url: "\(BASE_REF)").childByAppendingPath("users").childByAppendingPath(userID)
        
        return currentUser!
    }
    
    
    
    func createNewAccount(uid: String, user: Dictionary<String, String>) {
        
        // A User is born.
        
        USER_REF.childByAppendingPath(uid).setValue(user)
    }
    
    func createNewJoke(joke: Dictionary<String, AnyObject>) {
        
        // Save the Joke
        // JOKE_REF is the parent of the new Joke: "jokes".
        // childByAutoId() saves the joke and gives it its own ID.
        
        let firebaseNewJoke = JOKE_REF.childByAutoId()
        
        // setValue() saves to Firebase.
        
        firebaseNewJoke.setValue(joke)
    }
}

//Firebase.defaultConfig().persistenceEnabled = true
//ref.keepSynced(true)