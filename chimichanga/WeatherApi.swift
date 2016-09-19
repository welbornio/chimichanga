//
//  WeatherApi.swift
//  chimichanga
//
//  Created by shake on 9/13/16.
//  Copyright © 2016 welbornio. All rights reserved.
//

import Foundation
import UIKit

class WeatherApi: NSObject {
    
    var locationList = [Location]()
    
    let currentWeatherURL = "http://api.openweathermap.org/data/2.5/weather"
    
    let HTTPService = HTTP()
    
    override init() {
        self.locationList.append(Location("San Francisco"))
        self.locationList.append(Location("New York"))
        self.locationList.append(Location("Salt Lake City"))
        super.init()
    }
    
    /**
     * Get populated list of static cities and the related data
     * @param onCompletion {func} Callback function
     * @returns {Void}
     */
    func getPopulatedList(_ onCompletion: @escaping ([Location]) -> Void) {
        
        let callGroup = DispatchGroup.init()
        
        locationList.forEach {
            (location: Location) -> Void in
            
            callGroup.enter()
            
            loadLocation(location, {
                callGroup.leave()
            })
        }
        
        callGroup.notify(queue: DispatchQueue.main) {
            onCompletion(self.locationList)
        }
    }
    
    /**
     * Get weather information for a specified location
     * @param location {Location} Specified location to load
     * @param onCompleted {func} Callback function
     * @returns {Void}
     */
    func loadLocation(_ location: Location, _ onCompleted: @escaping() -> Void) -> Void {
        
        let escapedLocation = location.city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
        let route = "\(currentWeatherURL)?units=Imperial&q=\(escapedLocation)&APPID=\(Constants.weatherAPIKey)"
        
        HTTPService.performGET(path: route, onCompletion: { json in
            do {
                
                let parsedData = try JSONSerialization.jsonObject(with: json, options: .allowFragments) as! [String:Any]
                
                // Parse out city information
                let mainObj = parsedData["main"] as! [String:Any]
                let temp = mainObj["temp"] as! Float
                let tempMin = mainObj["temp_min"] as! Float
                let tempMax = mainObj["temp_max"] as! Float
                let weatherObj = parsedData["weather"] as! [[String:Any]]
                let icon = weatherObj[0]["icon"] as! String
                
                // Update location with new info
                location.temperature = temp
                location.temperatureMin = tempMin
                location.temperatureMax = tempMax
                location.createImage(icon, onCompletion: {
                    onCompleted()
                })
                
            } catch let error as NSError {
                print(error)
            }
        })
    }
    
}
