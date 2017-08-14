//
//  textViewPlaceholder.swift
//  heartThem
//
//  Created by Tushar Katyal on 14/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import UIKit

class textViewPlaceholder: UITextView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        text = "Caption here"
        textColor = UIColor.lightGray
        

    }
    
}
