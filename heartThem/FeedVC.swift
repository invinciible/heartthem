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
class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logOutBtnPressed(_ sender: Any) {
     
        try! Auth.auth().signOut()
        if KeychainWrapper.standard.removeObject(forKey: KEY_UID) {
        self.dismiss(animated: true, completion: nil)
        }
    }

}
