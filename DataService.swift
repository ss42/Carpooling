//
//  Firebase.swift
//  Carpooling
//
//  Created by Sanjay Shrestha on 4/15/16.
//  Copyright © 2016 St Marys. All rights reserved.
//


import Foundation
import Firebase

//imports firebase and foundation


let BASE_URL =  "http://smcpool.firebaseio.com"

// Website that contains the backend of the app

class DataService {
    static let dataService = DataService()
    
    var baseRef = Firebase(url: "\(BASE_URL)")
    var userRef = Firebase(url: "\(BASE_URL)/users")
    var postRef = Firebase(url: "\(BASE_URL)/posts")
    var requestRideRef = Firebase(url:  "\(BASE_URL)/requestRidesPost")
    
// Firebase for users and posting done inside the app
  
    
    var CURRENT_USER_REF: Firebase {
        let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
        
        let currentUser = Firebase(url: "\(baseRef)").childByAppendingPath("users").childByAppendingPath(userID)
        
        return currentUser!
// User ID setup
    }
    

    func createNewAccount(uid: String, user: Dictionary<String, String>) {
        // A User is born.
        userRef.childByAppendingPath(uid).setValue(user)
    }
    
    func createNewPost(trip: Dictionary<String, AnyObject>) {
        
        let firebaseNewPost = postRef.childByAutoId()
        
        print(firebaseNewPost.key)
        //var postId = firebaseNewPost.key

        //print(postId)
        // setValue() saves to Firebase.
        
        // make a block here to wait until upload is done before going back to home view controller
        
        var trip2 = trip
        trip2["postId"] = firebaseNewPost.key
        firebaseNewPost.setValue(trip2)
        //let postId = firebaseNewPost.key
        //print(postId)
        //let dict:[String:String] = ["postId":postId]
        //trip2["postId"] = "1231"
        //print("before assignment")
        //firebaseNewPost.setValue(trip2)
        print("after assignment")
        
    }
    
    func createNewRequest(trip: Dictionary<String, AnyObject>) {
        
        let firebaseNewPost = requestRideRef.childByAutoId()
        
        // setValue() saves to Firebase.
        
        firebaseNewPost.setValue(trip)
        
        
    }
}



//Firebase.defaultConfig().persistenceEnabled = true
//ref.keepSynced(true)