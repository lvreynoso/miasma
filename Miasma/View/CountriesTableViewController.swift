//
//  CountriesTableViewController.swift
//  Miasma
//
//  Created by Lucia Reynoso on 12/14/18.
//  Copyright © 2018 Lucia Reynoso. All rights reserved.
//

import UIKit

class CountriesTableViewController: UITableViewController {
    
    var receivedContinent: String?
    var regions: [String] = []
    var regionData: [String: [Dictionary<String, Any>]] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        guard let continent = receivedContinent else {
            print("Did not find a proper continent, aborting...")
            return
        }
        self.title = continent
        
        // setup for the proper continent
        guard let continentData = getContinentData(continent: continent) else {
            print("Could not get continent data!")
            return
        }
        guard let regionDict = continentData["Regions"] else {
            print("Could not get region data!")
            return
        }
        regions = Array(continentData["Regions"]?.keys ?? [:].keys)
        for region in regions {
            if let data = regionDict[region] as? [Dictionary<String, Any>] {
                regionData[region] = data
            }
        }
        print(regions)
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        let sections = regions.count
        return sections
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return regions[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let region = regions[section]
        if let sectionArray = regionData[region] {
            return sectionArray.count
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "country", for: indexPath)

        // Configure the cell...
        let region = regions[indexPath.section]
        guard let countriesArray = regionData[region] else {
            print("Error retrieving region data")
            return cell
        }
        let country = countriesArray[indexPath.row]
        guard let countryName = country["name"] as? String else {
            print("Error retrieving country data")
            return cell
        }
        
        cell.textLabel?.text = countryName
        
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
