//
//  AdminViewController.swift
//  ParkingApp
//
//  Created by Brandon Merhai on 7/1/20.
//  SBUID: 110489531
//  Copyright © 2020 Brandon Merhai. All rights reserved.
//

import UIKit
import Firebase

class AdminViewController: UIViewController {
    // MARK: - Properties
    
    @IBOutlet weak var aUsernameField: UITextField!
    @IBOutlet weak var aPasswordField: UITextField!
    
    // MARK: - Load View
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Login and Navigation
    
    @IBAction func aLoginButton(_ sender: Any) {
        let userField = aUsernameField?.text
        let passField = aPasswordField?.text
        
        Auth.auth().signIn(withEmail: userField!, password: passField!) { [weak self] authResult, error in
            if let error = error{
                print(error.localizedDescription)
            }
            else{
                let uid = Auth.auth().currentUser?.uid
                
                if uid == "RgGwYpB0WyY9X9KsuAEc3tFJNwU2"{
                    self!.performSegue(withIdentifier: "adminView", sender: self)
                    let user = Auth.auth().currentUser
                }
                else{
                    do {
                        try Auth.auth().signOut()
                    } catch let signOutError as NSError {
                        print ("Error signing out: %@", signOutError)
                    }
                }
            }
        }
    }
}
