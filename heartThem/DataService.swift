//
//  DataService.swift
//  heartThem
//
//  Created by Tushar Katyal on 13/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

//singleton class
class DataService {
    
    
    static let ds = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_POSTS = DB_BASE.child("Posts")
    
    var REF_BASE : DatabaseReference {
        
        return _REF_BASE
    }
    
    var REF_USERS : DatabaseReference {
        return _REF_USERS
    }
    
    var REF_POSTS : DatabaseReference {
        
        return _REF_POSTS
    }
    
    
    func createFirebaseDBUser(uid : String , userData : Dictionary<String,String>) {
        
        REF_USERS.child(uid).updateChildValues(userData)
    }

    
}
