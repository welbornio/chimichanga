//
//  HTTP.swift
//  chimichanga
//
//  Created by shake on 9/18/16.
//  Copyright © 2016 welbornio. All rights reserved.
//

import Foundation

class HTTP: NSObject {
    
    /**
     * Load data from specified URL
     * @param url {URL} URL to load from
     * @param onCompleted {func} Callback function
     * @returns {Void}
     */
    func loadUrl(url: URL, onCompleted: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            onCompleted(data, response, error)
        }
        
        task.resume()
    }
    
    /**
     * Perform a GET request on a specified path
     * @param path {String} Request url
     * @param onCompleted {func} Callback function
     * @returns {Void}
     */
    func performGET(path: String, onCompleted: @escaping (_ data: Data) -> Void) {
        let url = URL(string: path)
        
        let task = URLSession.shared.dataTask(with: url! as URL) { data, response, error in
            if error != nil {
                print(error)
            } else {
                onCompleted(data!)
            }
        }
        
        task.resume()
    }
    
}
