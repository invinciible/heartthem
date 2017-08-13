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
import SwiftKeychainWrapper

class SignInVC: UIViewController {

    @IBOutlet weak var emailTextField: FancyTextField!
    
    @IBOutlet weak var passwordTextField: FancyTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID){
            
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }
        
        
    }
    // Facebook User login request 
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

    // firebase auth for Facebook
    func firebaseAuth(_ credential : AuthCredential) {
        
        Auth.auth().signIn(with: credential) { (user, error) in
            
            if error != nil {
                print("Tush : unable to authenticate with firebase")
            } else {
                print("tush : successfully authenticate with facebook")
                if let user = user {
                    
                    let userData = ["provider" : credential.provider]
                   self.signInComplete(id: user.uid , userData: userData)
                }
                
            }
        }
    }
    
    //Email Auth Action
    @IBAction func signInBtnTapped(_ sender: Any) {
        
        if let email = emailTextField.text , let pass = passwordTextField.text {
            
            Auth.auth().signIn(withEmail: email, password: pass, completion: { (user, error) in
                if error == nil {
                    print("tush : successfully Sign in using firebase")
                    if let user = user {
                        let userData = ["provider" : user.providerID]
                        self.signInComplete(id: user.uid ,userData: userData)
                    }
                } else {
                    
                    Auth.auth().createUser(withEmail: email, password: pass, completion: { (user, error) in
                        
                        if error != nil {
                            print("tush : authentication error")
                        } else {
                            print("tush : user created success on firebase")
                            if let user = user {
                                let userData = ["provider" : user.providerID]
                                self.signInComplete(id: user.uid,userData: userData)
                            }
                        }
                    })
                }
                
            })
        }
        
    }
    func signInComplete(id : String, userData : Dictionary<String,String>){
        
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
       let keychainResult = KeychainWrapper.standard.set(id,forKey :KEY_UID)
        print("tush :data saved success in keychain \(keychainResult)")
        performSegue(withIdentifier: "goToFeed", sender: nil)
    }
    
}

