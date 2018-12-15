//
//  DetailsTableViewController.swift
//  Miasma
//
//  Created by Lucia Reynoso on 12/14/18.
//  Copyright © 2018 Lucia Reynoso. All rights reserved.
//

import UIKit

class DetailsTableViewController: UITableViewController {
    
    var receivedCountry: String?
    var receivedCountryData: [String: Any]?
    var pollutants: [Dictionary<String, Any>]?
    let displayOrder = [["total", "Total"], ["perCapita", "Per Capita"], ["perGDP", "Per GDP"]]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.title = receivedCountry
        pollutants = receivedCountryData?["pollutants"] as? [Dictionary<String, Any>]
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        var sections = 0
        if pollutants != nil {
            sections = pollutants!.count
        }
        return sections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let pollutant = pollutants?[section] else {
            print("Could not find pollutant")
            return 0
        }
        return displayOrder.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let pollutant = pollutants?[section] else {
            print("Could not find pollutant")
            return nil
        }
        guard let name = pollutant["name"] as? String else {
            print("Invalid value found for pollutant name")
            return nil
        }
        return name
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detail", for: indexPath)

        // Configure the cell...
        guard let pollutant = pollutants?[indexPath.section] else {
            print("Could not find pollutant")
            return cell
        }
        let property = displayOrder[indexPath.row]
        guard let value = pollutant[property[0]] else {
            print("Could not unwrap optional 'value'")
            return cell
        }
        cell.textLabel?.text = property[1]
        cell.detailTextLabel?.text = "\(String(describing: value))"
        
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
