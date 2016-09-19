//
//  LocationList.swift
//  chimichanga
//
//  Created by shake on 9/18/16.
//  Copyright © 2016 welbornio. All rights reserved.
//

import Foundation

class LocationList: NSObject {
    var list = [Location]()
    
    /**
     * Populate initial list of static cities and the related data
     * @param onCompleted {func} Callback function
     * @returns {Void}
     */
    func hydrate(_ onCompleted: @escaping() -> Void) -> Void {
        let cities = ["San Francisco", "New York", "Salt Lake City"]
        
        let callGroup = DispatchGroup.init()
        
        cities.forEach {
            (city: String) -> Void in
            
            callGroup.enter()
            
            let location = Location(city)
            
            WeatherApi.sharedInstance.loadLocation(location, {
                self.list.append(location)
                callGroup.leave()
            })
        }
        
        callGroup.notify(queue: DispatchQueue.main) {
            onCompleted()
        }
    }
    
    /**
     * Add a new location to the list
     * @param city {String} City name
     * @param onCompleted {func} Callback function
     * @returns {Void}
     */
    func addNewLocation(_ city: String, _ onCompleted: @escaping([Location]) -> Void) -> Void {
        let location = Location(city)
        WeatherApi.sharedInstance.loadLocation(location, {
            self.list.append(location)
            onCompleted(self.list)
        })
    }
    
    /**
     * Remove a location from the location list
     * @param location {Location} Location to be removed
     * @param onCompleted {func} Callback function
     * @returns {Void}
     */
    func removeLocation(_ location: Location, _ onCompleted: @escaping() -> Void) -> Void {
        for (index, _location) in list.enumerated() {
            if _location === location {
                list.remove(at: index)
            }
        }
        onCompleted()
    }
    
    /**
     * View a single location
     * @param location {Location} Single location to be viewed
     * @param onCompleted {func} Callback function
     * @returns {Void}
     */
    func viewLocation(_ location: Location, _ onCompleted: @escaping() -> Void) -> Void {
        WeatherApi.sharedInstance.loadLocation(location, {
            onCompleted()
        })
    }
}
