//
//  RegisterViewController.swift
//  ParkingApp
//
//  Created by Brandon Merhai on 7/1/20.
//  SBUID: 110489531
//  Copyright © 2020 Brandon Merhai. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class RegisterViewController: UIViewController {
    //MARK: - Properties
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    var db: Firestore!
    
    var currentLot: String?
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stepper.wraps = true
        stepper.maximumValue = 60
        stepper.minimumValue = 1
        stepper.value = stepper.minimumValue
        stepper.autorepeat = true
        timeLabel.text? = Int(stepper.value).description
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Update Button
    
    @IBAction func updateButton(_ sender: Any) {
        let userID = Auth.auth().currentUser!.uid
        var lotNo = 5
        if currentLot == "Zone 1"{
            lotNo = 1
        }
        else if currentLot == "Zone 3"{
            lotNo = 2
        }
        else if currentLot == "Zone 4"{
            lotNo = 3
        }
        else if currentLot == "Zone 5"{
            lotNo = 4
        }
        else{
            lotNo = 5
        }
        let lotStr = "\(lotNo)"
        //db.collection("lots").document(lotStr).setData(["cars": [userID]], merge: true)
        let userRef = db.collection("lots").document(lotStr)
        userRef.updateData(["cars": FieldValue.arrayUnion([userID])])
        let timeRef = db.collection("users").document(userID)
        let calendar = Calendar.current
        let date = calendar.date(byAdding: .minute, value: Int(stepper.value), to: Date())
        
        timeRef.getDocument{ (document, error) in
            if let document = document, document.exists{
                
                timeRef.updateData(["time": Int(self.stepper.value)])
                timeRef.updateData(["valid until":date])
                
                let alert = UIAlertController(title: "Confirmation", message: "Registered for \((Int)(self.stepper.value)) minutes.", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            }
            else{
                let alert = UIAlertController(title: "Update your car information first!", message: "Go to the settings page and enter your information.", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        
        
    }
    
    //MARK: - Stepper Action
    
    @IBAction func stepperClicked(_ sender: UIStepper) {
        timeLabel.text = Int(sender.value).description
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
