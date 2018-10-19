//
//  BlameController.swift
//  Miasma
//
//  Created by Lucia Reynoso on 10/19/18.
//  Copyright © 2018 Lucia Reynoso. All rights reserved.
//

import UIKit

struct Country {
    var name: String
    var flag: UIImage?
    var highlight: String
}

class BlameController: UITableViewController {
    
    var regions = ["North America", "Europe", "Asia", "South America", "Central America", "Africa", "Caribbean", "Middle East"]
    var northAmerica = [Country(name: "United States of America", flag: UIImage(named: "usa"), highlight: "First World, Global Problem"), Country(name: "Canada", flag: UIImage(named: "can"), highlight: "High per capita Carbon Dioxide Output"), Country(name: "Mexico", flag: UIImage(named: "mex"), highlight: "Mexico City is notorious for its smog")]
    var europe = [Country(name: "United Kingdom", flag: nil, highlight: "Can Brexit Europe, can't escape pollution"), Country(name: "France", flag: nil, highlight: "Record heat waves")]
    var asia = [Country(name: "China", flag: nil, highlight: "The world's worst polluter"), Country(name: "India", flag: nil, highlight: "Sacred land, toxic water")]
    var southAmerica = [Country(name: "Brazil", flag: nil, highlight: "Burning the Amazon rainforest")]
    var centralAmerica = [Country(name: "Panama", flag: nil, highlight: "Canal transport kills the Earth")]
    var africa = [Country(name: "Nigeria", flag: nil, highlight: "Oil production fuels economy and heats the globe")]
    var caribbean = [Country(name: "Cuba", flag: nil, highlight: "Commienism")]
    var middleEast = [Country(name: "Egypt", flag: nil, highlight: "Suez tankers fuel warming")]
    
    var countries: [Int: [Country]] = [:]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries[0] = northAmerica
        countries[1] = europe
        countries[2] = asia
        countries[3] = southAmerica
        countries[4] = centralAmerica
        countries[5] = africa
        countries[6] = caribbean
        countries[7] = middleEast

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return regions.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if countries[section] != nil {
            return countries[section]!.count
        } else {
           return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Blame", for: indexPath)
        
        if let section = countries[indexPath.section] {
            cell.textLabel?.text = section[indexPath.row].name
            if let flag = section[indexPath.row].flag {
                cell.imageView?.image = flag
            }
            cell.detailTextLabel?.text = section[indexPath.row].highlight
        } else {
            cell.textLabel?.text = "Test"
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if regions[section] != nil {
            return regions[section]
        } else {
            return "Error"
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.default
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
