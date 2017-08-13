//
//  Posts.swift
//  heartThem
//
//  Created by Tushar Katyal on 13/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import Foundation


class Posts {
    
    
    private var _caption : String!
    private var _likes : Int!
    private var _imageurl : String!
    private var _postkey : String!
    var caption : String {
        return _caption
    }
    
    var likes : Int {
        return _likes
    }
    
    var imageurl : String {
        return _imageurl
    }
    var postkey : String {
        return _postkey
    }
    
    init(caption: String ,likes : Int , imageurl : String) {
        
        self._caption = caption
        self._imageurl = imageurl
        self._likes = likes
    }
    init(postkey : String , postData : Dictionary<String,AnyObject>) {
        
        self._postkey = postkey
        if let caption = postData["caption"] as? String {
            self._caption = caption
        }
        
        if let imageurl = postData["imageurl"] as? String {
            self._imageurl = imageurl
        }
        if let likes = postData["likes"] as? Int {
            
            self._likes = likes
        }
        
    }
    
}
