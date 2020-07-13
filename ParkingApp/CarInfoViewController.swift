//
//  CarInfoViewController.swift
//  ParkingApp
//
//  Created by Brandon Merhai on 7/3/20.
//  SBUID: 110489531
//  Copyright © 2020 Brandon Merhai. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class CarInfoViewController: UIViewController {
    //MARK: - Properties
    @IBOutlet weak var licenseNo: UITextField!
    @IBOutlet weak var color: UITextField!
    @IBOutlet weak var make: UITextField!
    @IBOutlet weak var model: UITextField!
    
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()

        let userID = Auth.auth().currentUser!.uid
        let docRef = db.collection("users").document(userID)
        
        docRef.getDocument{(document, error) in
            if let document = document, document.exists {
                let savedLicense = document.get("license")
                let savedColor = document.get("carColor")
                let savedMake = document.get("carMake")
                let savedModel = document.get("carModel")
                
                if savedLicense != nil {
                    self.licenseNo.text = savedLicense as? String
                    self.color.text = savedColor as? String
                    self.make.text = savedMake as? String
                    self.model.text = savedModel as? String
                }
            }
        }
    }
    
    //MARK: - Update Button 
    
    @IBAction func update(_ sender: Any) {
        let license = licenseNo.text
        let carColor = color.text
        let carMake = make.text
        let carModel = model.text
        
        
        let userID = Auth.auth().currentUser!.uid
        db.collection("users").document(userID).setData([
            "license": license,
            "carColor": carColor,
            "carMake": carMake,
            "carModel": carModel])
        
        let alert = UIAlertController(title: "Confirmation", message: "Information saved!", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
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
