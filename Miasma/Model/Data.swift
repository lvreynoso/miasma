//
//  Data.swift
//  Miasma
//
//  Created by Lucia Reynoso on 12/14/18.
//  Copyright © 2018 Lucia Reynoso. All rights reserved.
//

import Foundation

func getWorldData(plist: String) -> [String: Any]? {
    var data: [String: Any]?
    // access the countdown date
    guard let dataUrl = Bundle.main.url(forResource: plist, withExtension: "plist") else {
        print("can't find \(plist).plist")
        return nil
    }
    do {
        data = try PropertyListSerialization.propertyList(from: Data(contentsOf: dataUrl), options: [], format: nil) as? [String: Any]
        
    } catch {
        print("can't create array from plist")
        return nil
    }
    
    return data
}

func getContinentData(continent: String) -> [String : Dictionary<String, Any>]? {
    guard let worldData = getWorldData(plist: "CountryData") else {
        print("Could not get world data!")
        return nil
    }
    
    // setup for the proper continent
    guard let continentData = worldData[continent] as? [String : Dictionary<String, Any>] else {
        print("Could not get continent data!")
        return nil
    }
    return continentData
}
