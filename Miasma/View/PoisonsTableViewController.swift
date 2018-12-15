//
//  PoisonsTableViewController.swift
//  Miasma
//
//  Created by Lucia Reynoso on 12/14/18.
//  Copyright © 2018 Lucia Reynoso. All rights reserved.
//

import UIKit

class PoisonsTableViewController: UITableViewController {
    
    var poisons: [Dictionary<String, Any>]?
    let headers: [String] = ["Greenhouse Gases"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        poisons = getPollutionData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return headers.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var rows = 0
        if let numberOfStoredPoisons = poisons?.count {
            rows = numberOfStoredPoisons
        }
        return rows
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "poison", for: indexPath)

        // Configure the cell...
        guard let poison = poisons?[indexPath.row] else {
            print("Unable to read poison at \(indexPath.row)")
            return cell
        }
        guard let poisonName = poison["name"] as? String else {
            print("Unable to read name of poison at \(indexPath.row)")
            return cell
        }
        
        cell.textLabel?.text = poisonName

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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let selectedCell = sender as? UITableViewCell else {
            print("Segue to next view was not initiated by a cell in the table!")
            return
        }
        guard let nextVC = segue.destination as? PoisonsDetailTableViewController else {
            print("Segue destination is not a country table view controller!")
            return
        }
        if let selectedIndex = self.tableView.indexPath(for: selectedCell) {
            nextVC.receivedPoisonData = poisons?[selectedIndex.row]
        } else {
            print("Error retrieving data for poison at selected index")
        }
        if let selectedPoisonName = selectedCell.textLabel?.text {
            nextVC.receivedPoisonName = selectedPoisonName
        } else {
            print("Error retrieving text of selected cell")
        }
        
    }

}
