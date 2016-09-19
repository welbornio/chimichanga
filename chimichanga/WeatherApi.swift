//
//  WeatherApi.swift
//  chimichanga
//
//  Created by shake on 9/13/16.
//  Copyright © 2016 welbornio. All rights reserved.
//

import Foundation
import UIKit

class WeatherApi {
    
    static let sharedInstance = WeatherApi()
    
    let currentWeatherURL = "http://api.openweathermap.org/data/2.5/weather"
    
    let HTTPService = HTTP()
    
    private init() {
        
    }
    
    /**
     * Get weather information for a specified location
     * @param location {Location} Specified location to load
     * @param onCompleted {func} Callback function
     * @returns {Void}
     */
    func loadLocation(_ location: Location, _ onCompleted: @escaping(Bool) -> Void) -> Void {
        
        let escapedLocation = location.city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
        let route = "\(currentWeatherURL)?units=Imperial&q=\(escapedLocation)&APPID=\(Constants.weatherAPIKey)"
        
        HTTPService.performGET(path: route, onCompleted: { json in
            do {
                
                let parsedData = try JSONSerialization.jsonObject(with: json, options: .allowFragments) as! [String:Any]
                
                
                let cod = parsedData["cod"] as? Int
                
                if cod == 200 {
                    
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
                    location.createImage(icon, onCompleted: {
                        onCompleted(true)
                    })
                    
                } else {
                    OperationQueue.main.addOperation {
                        onCompleted(false)
                    }
                }
                
            } catch {
                print("An Error Occurred")
            }
        })
    }
    
}
