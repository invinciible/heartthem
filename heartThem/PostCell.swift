//
//  PostCell.swift
//  heartThem
//
//  Created by Tushar Katyal on 12/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    
    
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var profilePicImg: RoundImage!
    @IBOutlet weak var userNameLbl: ShadowOnLabel!
    @IBOutlet weak var captionLbl: UILabel!
    @IBOutlet weak var noOfLikesLbl: ShadowOnLabel!
    
    var post : Posts!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    func configureCell(post : Posts) {
        
        self.post = post
        self.captionLbl.text = post.caption
        self.noOfLikesLbl.text = "\(post.likes)"
        
    }

}
