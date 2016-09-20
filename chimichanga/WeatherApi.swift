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
    
    let forecastWeatherURL = "http://api.openweathermap.org/data/2.5/forecast/daily"
    
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
                    let weatherObj = parsedData["weather"] as! [[String:Any]]
                    let icon = weatherObj[0]["icon"] as! String
                    
                    // Update location with new info
                    location.temperature = temp
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
    
    /**
     * Load the forecast for this location
     * @param location {Location} Location we are querying for
     * @param onCompleted {func} Callback function
     * @returns {Void}
     */
    func loadForecast(_ location: Location, _ onCompleted: @escaping() -> Void) -> Void {
        let escapedLocation = location.city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
        let route = "\(forecastWeatherURL)?q=\(escapedLocation)&cnt=1&units=imperial&appid=\(Constants.weatherAPIKey)"
        
        HTTPService.performGET(path: route, onCompleted: { json in
            do {
                
                let parsedData = try JSONSerialization.jsonObject(with: json, options: .allowFragments) as! [String:Any]
                
                let cod = parsedData["cod"] as? String
                
                if cod == "200" {
                    
                    // Parse out city information
                    let listObj = parsedData["list"] as! [[String:Any]]
                    let temp = listObj[0]["temp"] as! [String:Any]
                    let minTemp = temp["min"] as! Float
                    let maxTemp = temp["max"] as! Float
                    
                    // Update location with new info
                    location.temperatureMin = minTemp
                    location.temperatureMax = maxTemp
                    
                    onCompleted()
                    
                } else {
                    OperationQueue.main.addOperation {
                        onCompleted()
                    }
                }
                
            } catch let error as NSError {
                print(error)
            }
        })
        
    }
    
}
