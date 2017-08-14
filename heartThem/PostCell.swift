//
//  PostCell.swift
//  heartThem
//
//  Created by Tushar Katyal on 12/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import UIKit
import Firebase
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
    
    func configureCell(post : Posts , img : UIImage?) {
        
        self.post = post
        self.captionLbl.text = post.caption
        self.noOfLikesLbl.text = "\(post.likes)"
        
        if img != nil {
            
            self.postImg.image = img
        } else {
            let ref = Storage.storage().reference(forURL: post.imageurl)
            ref.getData(maxSize : 2 * 1024 * 1024 , completion : { (data, error) in
                
                if error != nil {
                    print("Tush : Unable to download image ")
                }
                else {
                    print("Tush : Image download success from firebase storage ")
                    
                    if let imgData = data {
                        
                        if let img = UIImage(data: imgData){
                            
                            self.postImg.image = img
                            // saving images to cache after they downloaded
                            FeedVC.imageCache.setObject(img, forKey: post.imageurl as NSString)
                        }
                    }
                }
            
            })
        }
    }
}
