//
//  ViewController.swift
//  heartThem
//
//  Created by Tushar Katyal on 11/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class SignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func fbLoginBtnTapped(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            
            
            if error != nil {
                
                print("Tush : unable to authentical with facebook - \(error ?? "Error authenticating" as! Error)")
            } else if result?.isCancelled == true {
                
                print("Tush : user cancelled fb suthentication")
            } else {
                print("Tush :successfully authenticate with facebook")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
                }
            }
        }

    func firebaseAuth(_ credential : AuthCredential) {
        
        Auth.auth().signIn(with: credential) { (user, error) in
            
            if error != nil {
                print("Tush : unable to authenticate with firebase")
            } else {
                print("tush : successfully authenticate with firebase")
            }
        }
    }
}

