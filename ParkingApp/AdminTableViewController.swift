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

class AdminTableViewController: UITableViewController {
    //MARK: - Properties
    
    var db: Firestore!
    var lotArray = [Lots]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.db = Firestore.firestore()
        let settings = self.db.settings
        self.db.settings = settings
        self.tableView.delegate = self
        self.tableView.dataSource = self
        loadData()
    }
    
    //MARK: - Load Data
    
    func loadData(){
        db.collection("lots").getDocuments() { (snapshot, err) in
            if let err = err{
                print("Error getting documents: \(err)")
            } else {
                    for document in snapshot!.documents{
                        let lotName = document.get("name") as? String ?? ""
                        print(lotName)
                        let lotCapacity = document.data()["capacity"] as? Int ?? 0
                        let lotLocation = document.get("location") as? String ?? ""
                        print(lotLocation)
                        
                        let lotUsage = document.get("cars") as? [String]
                        var thisLotCount = 0
                        
                        if lotUsage?.isEmpty ?? true{
                        }
                        else{
                            thisLotCount = lotUsage?.count as! Int
                        }
                        
                    
                        let newLot = Lots(name: lotName, capacity: lotCapacity, location: lotLocation, lotCount: thisLotCount)
                        self.lotArray.append(newLot)
                    }
                    self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return lotArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdminTableViewCell", for: indexPath) as! AdminTableViewCell

       /* // Configure the cell...
        let lot = lots[indexPath.row]
        let lotNameV = lot.0
        cell.lotName?.text = lot.0
        cell.location?.text = lot.2
        cell.capacity?.text = lot.1
        */
        
        let lot = lotArray[indexPath.row]
        cell.lotName?.text = lot.name
        cell.location?.text = lot.location
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

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
        
        let selectedLot = lotArray[indexPath.row].name
        
        self.performSegue(withIdentifier: "adminSeeAll", sender: tableView.cellForRow(at: indexPath))
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "adminSeeAll"{
            let adminAll = segue.destination as? AdminAllTableViewController
            let selectedRow = self.tableView.indexPath(for: sender as! UITableViewCell)?.row
            let selectedLot = lotArray[selectedRow!].name
            adminAll?.currentLot = selectedLot
        }
    }
    
    
}

class AdminTableViewCell: UITableViewCell{
    @IBOutlet weak var lotName: UILabel!
    @IBOutlet weak var location: UILabel!
    
    
}
