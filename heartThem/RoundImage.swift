//
//  RoundImage.swift
//  heartThem
//
//  Created by Tushar Katyal on 12/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import UIKit

class RoundImage: UIImageView {

   override func awakeFromNib() {
        super.awakeFromNib()
    
    layer.shadowColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.8).cgColor
    layer.shadowRadius = 3.0
    layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    layer.shadowOpacity = 0.8
    
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.width / 2
        
//        clipsToBounds = true
    }
}
