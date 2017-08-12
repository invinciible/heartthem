//
//  FancyTextField.swift
//  heartThem
//
//  Created by Tushar Katyal on 12/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import UIKit

class FancyTextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib() 
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
        
    }
    
    // placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 5.0, dy: 3)
    }
    
    // user text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 5.0, dy: 3)
    }
}
