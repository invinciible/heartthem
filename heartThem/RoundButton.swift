//
//  RoundButton.swift
//  heartThem
//
//  Created by Tushar Katyal on 12/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import UIKit

class RoundButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.6).cgColor
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.shadowOpacity = 0.6
        layer.cornerRadius = 5.0
    }

}
