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
class FeedVC: UIViewController ,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView : UITableView!
    
    var posts = [Posts]()
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
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
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        print("Tush : \(post.caption)")
        
        return tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    
    @IBAction func logOutBtnPressed(_ sender: Any) {
     
        try! Auth.auth().signOut()
        if KeychainWrapper.standard.removeObject(forKey: KEY_UID) {
        self.dismiss(animated: true, completion: nil)
        }
    }

}
