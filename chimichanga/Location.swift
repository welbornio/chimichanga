//
//  Location.swift
//  chimichanga
//
//  Created by shake on 9/13/16.
//  Copyright © 2016 welbornio. All rights reserved.
//

import Foundation
import UIKit

class Location: NSObject {
    var city: String
    var temperature: Float?
    var temperatureMin: Float?
    var temperatureMax: Float?
    var icon: URL?
    var image: UIImage?
    
    let HTTPService = HTTP()
    
    /**
     * Location constructor
     */
    init(_ city: String) {
        self.city = city
    }
    
    /**
     * Set the icon path, and create an image for this location
     * @param icon {String} Icon ID
     * @returns Void
     */
    func createImage(_ icon: String, onCompletion: @escaping() -> Void ) -> Void {
        self.icon = URL(string: "http://openweathermap.org/img/w/\(icon).png")
        
        HTTPService.loadUrl(url: self.icon!, onCompletion: { (data, response, error) in
            DispatchQueue.main.sync() { () -> Void in
                if error != nil {
                    print(error)
                } else {
                    self.image = UIImage(data: data!)
                    onCompletion()
                }
            }
        })
    }
}
