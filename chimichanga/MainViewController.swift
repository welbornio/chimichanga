//
//  MainViewController.swift
//  chimichanga
//
//  Created by shake on 9/13/16.
//  Copyright © 2016 welbornio. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView = UITableView()
    
    let weatherApi = WeatherApi()
    
    var locationList = [Location]()
    
    /**
     * Post view load
     */
    override func viewDidLoad() -> Void {
        super.viewDidLoad()
        
        tableView.frame.size.width = self.view.frame.size.width
        tableView.frame.size.height = self.view.frame.size.height
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.layoutMargins = UIEdgeInsets.zero
        self.view.addSubview(tableView)
        
        weatherApi.getPopulatedList { list in
            self.locationList = list
            self.tableView.reloadData()
        }
    }
    
    /**
     * Implement tableView numberOfRowsInSection
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locationList.count
    }
    
    /**
     * Implement tableView cellForRow
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        let location = self.locationList[indexPath.row]
        
        cell.imageView!.image = location.image
        cell.textLabel?.text = "\(location.city) \(location.temperature!)\u{00B0}"
        
        return cell
    }
    
    /**
     * Implement tableView didSelectRow
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = self.locationList[indexPath.row]
        weatherApi.loadLocation(location, {
            self.tableView.reloadData()
            let detailViewController:DetailViewController = DetailViewController(location)
            self.navigationController?.pushViewController(detailViewController, animated: true)
        })
    }
    
}
