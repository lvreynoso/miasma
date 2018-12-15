//
//  PoisonsDetailTableViewController.swift
//  Miasma
//
//  Created by Lucia Reynoso on 12/14/18.
//  Copyright © 2018 Lucia Reynoso. All rights reserved.
//

import UIKit

class PoisonsDetailTableViewController: UITableViewController {
    
    var receivedPoisonName: String = "None"
    var receivedPoisonData: [String: Any]?
    let sectionHeaders: [String] = ["Poison Details"]
    let poisonDetailKeys = ["formula", "lifetime", "gwp20", "gwp100", "gwp500", "conc"]
    let poisonDetailTitles = ["Formula", "Lifetime", "Global Warming Potential - 20 years", "Global Warming Potential - 100 years", "Global Warming Potential - 500 years", "Atmospheric Concentraion"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.title = receivedPoisonName
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sectionHeaders.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return poisonDetailKeys.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "poisonDetail", for: indexPath)

        // Configure the cell...
        let key = poisonDetailKeys[indexPath.row]
        guard let data = receivedPoisonData?[key] else {
            print("Couldn't get data from key at \(indexPath)")
            return cell
        }
        
        cell.textLabel?.text = poisonDetailTitles[indexPath.row]
        cell.detailTextLabel?.text = "\(String(describing: data))"
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
