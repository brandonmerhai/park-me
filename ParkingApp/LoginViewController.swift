//
//  LoginViewController.swift
//  ParkingApp
//
//  Created by Brandon Merhai on 7/1/20.
//  SBUID: 110489531
//  Copyright © 2020 Brandon Merhai. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    //MARK: - Properties
    
    var defaults = UserDefaults.standard
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var login: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Login Button
    
    @IBAction func loginButton(_ sender: Any) {
        let usr = (username?.text)!
        let pwd = (password?.text)!
        
        /*if isPresentInDefaults(key: usr){
            if pwd == defaults.string(forKey: usr){
                performSegue(withIdentifier: "loginRegular", sender: self)
            }
        */
        Auth.auth().signIn(withEmail: usr, password: pwd) { [weak self] authResult, error in
            if let error = error{
                print(error.localizedDescription)
            }
            else{
                self!.performSegue(withIdentifier: "loginRegular", sender: self)
                let user = Auth.auth().currentUser
            }
          // ...
        }
        
    }
    
    func isPresentInDefaults(key: String) -> Bool{
        return UserDefaults.standard.object(forKey: key) != nil
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
