//
//  FeedVC.swift
//  heartThem
//
//  Created by Tushar Katyal on 12/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase
class FeedVC: UIViewController ,UITableViewDelegate,UITableViewDataSource ,UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    @IBOutlet weak var addImgThumb: RoundImage!
    @IBOutlet weak var tableView : UITableView!
    var imagePicker : UIImagePickerController!
    var selectedImg = false
    @IBOutlet weak var captionTextField: UITextField!
    
    static var imageCache : NSCache<NSString, UIImage> = NSCache()
    
    var posts = [Posts]()
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        
        // setting up of observer , which will observe the live updates
        DataService.ds.REF_POSTS.observe(.value , with : { (snapshot) in
            
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot]{
                
                for snap in snapshot {
                    
                    if let postDict = snap.value as? Dictionary<String,AnyObject> {
                    
                        let key = snap.key
                        let post = Posts(postkey: key, postData: postDict)
                        self.posts.append(post)
                        
                    
                    }
                    
                }
                
            }
        self.tableView.reloadData()
    })

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let post = posts[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
            
            // checking if there's a cache available pass that to cell
            if let img = FeedVC.imageCache.object(forKey: post.imageurl as NSString)
            {
                
                cell.configureCell(post: post, img: img)
                return cell
            } else {
                 cell.configureCell(post: post , img: nil )
                return cell
            }
           
        }
        else {
        return PostCell()
     }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            addImgThumb.image = image
            selectedImg = true
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addImgTapped(_ sender: Any) {
        
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func addImgBtnTapped(_ sender: Any) {
        
        
        guard let caption = captionTextField.text , caption != "" else {
            
            print("tush : Caption must be there")
            return
        }
        
        guard let img = addImgThumb.image , selectedImg == true else {
            
            print("Tush ; image must be selected")
            return
        }
        
        if let imgData = UIImageJPEGRepresentation(img, 0.2) {
            
            let imgUID = NSUUID().uuidString
            let metaData = StorageMetadata()
            
            metaData.contentType = "image/jpeg"
            
            DataService.ds.REF_POST_IMAGES.child(imgUID).putData(imgData, metadata: metaData, completion: { (metaData, error) in
                
                
                if error != nil {
                    
                    print("Tush : Image upload failed")
                } else {
                    
                    print("Tush : image upload success")
                    
                    let downloadURl = metaData?.downloadURL()?.absoluteString
                }
                
                
            })
        }
        
    }
    
    
    
    @IBAction func logOutBtnPressed(_ sender: Any) {
     
        try! Auth.auth().signOut()
        if KeychainWrapper.standard.removeObject(forKey: KEY_UID) {
        self.dismiss(animated: true, completion: nil)
        }
    }

}
