//
//  AddAccountViewController.swift
//  ParkingApp
//
//  Created by Brandon Merhai on 7/1/20.
//  SBUID: 110489531
//  Copyright © 2020 Brandon Merhai. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class AddAccountViewController: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var passField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let arr = [String]()
        
        //defaults.set(arr, forKey: "info")
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Register Button
    
    @IBAction func registerButton(_ sender: Any) {
        
        let email = (userField?.text)!
        let pass = (passField?.text)!
        //defaults.set(pass, forKey: user)
        let ref = FirebaseDatabase.Database.database()
        Auth.auth().createUser(withEmail: email, password: pass) { authResult, error in
          // ...
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
