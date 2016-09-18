//
//  WeatherApi.swift
//  chimichanga
//
//  Created by shake on 9/13/16.
//  Copyright © 2016 welbornio. All rights reserved.
//

import Foundation

typealias ServiceResponse = (JSON, NSError?) -> Void

class WeatherApi: NSObject {
    
    var locations: [Location] = [Location(city: "San Francisco"), Location(city: "New York"), Location(city: "Salt Lake City")];
    
    let currentWeatherURL = "http://api.openweathermap.org/data/2.5/weather"
    
    func getPopulatedList(onCompletion: (JSON) -> Void) {
        var response = [String]()
        for location in locations {
            let escapedLocation = location.city.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
            
            let route = "\(currentWeatherURL)?units=Imperial&q=\(escapedLocation)&APPID=\(Constants.weatherAPIKey)"
            
            makeHTTPGetRequest(route, onCompletion: { json, err in
                onCompletion(json as JSON)
            })
        }
    }
    
    func makeHTTPGetRequest(path: String, onCompletion: ServiceResponse) {
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            let json:JSON = JSON(data: data!)
            onCompletion(json, error)
        })
        task.resume()
    }
    
}