//
//  RegularTableViewController.swift
//  ParkingApp
//
//  Created by Brandon Merhai on 7/1/20.
//  SBUID: 110489531
//  Copyright © 2020 Brandon Merhai. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FirebaseFirestore

class AdminAllTableViewController: UITableViewController {
    //MARK: - Properties
    
    var currentLot: String?
    
    var db: Firestore!
    var carList = [String]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.db = Firestore.firestore()
        let settings = self.db.settings
        self.db.settings = settings
        self.tableView.delegate = self
        self.tableView.dataSource = self
        print(currentLot)
        loadData()
    }
    
    //MARK: - Load Data
    
    func loadData(){
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
        
        
        
        let docRef = db.collection("lots").document(lotStr)
        docRef.getDocument() { (document, err) in
            if let err = err{
                print("Error getting documents: \(err)")
            } else {
                let lotList = document?.get("cars") as! [String]
            
                self.carList = lotList
                }
                
                
                self.tableView.reloadData()
            }
        }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return carList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdminAllTableViewCell", for: indexPath) as! AdminAllTableViewCell

       /* // Configure the cell...
        let lot = lots[indexPath.row]
        let lotNameV = lot.0
        cell.lotName?.text = lot.0
        cell.location?.text = lot.2
        cell.capacity?.text = lot.1
        */
        let docRef = db.collection("users").document(carList[indexPath.row])
               
               docRef.getDocument{(document, error) in
                   if let document = document, document.exists {
                    
                    let validUntilLabel = document.get("valid until")
                       
                       if validUntilLabel != nil {
                        let validDate = validUntilLabel as! Timestamp
                        let formatter = DateFormatter()
                        formatter.dateFormat = "HH:mm E, d MMM y"
                        var dateStr = formatter.string(from: validDate.dateValue())
                        
                        cell.valid?.text = "Valid Until: \(dateStr)"
                       }
                   }
               }
        
        
        cell.user?.text = carList[indexPath.row]
        
        return cell
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let name = carList[indexPath.row]
            
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
            
            let docRef = db.collection("lots").document(lotStr)
            docRef.updateData(["cars": FieldValue.arrayRemove([name])])
            self.carList.remove(at: indexPath.row)
            tableView.reloadData()

        }
        
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath:IndexPath){
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
}

class AdminAllTableViewCell: UITableViewCell{
    @IBOutlet weak var user: UILabel!
    @IBOutlet weak var valid: UILabel!
    
}
