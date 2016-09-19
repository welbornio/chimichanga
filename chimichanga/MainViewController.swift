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
    
    var textField: UITextField = UITextField()
    
    var locationList = LocationList()
    
    /**
     * Post view load
     */
    override func viewDidLoad() -> Void {
        super.viewDidLoad()
        self.renderTableView()
        self.renderNewField()
        self.renderNewButton()
        
        locationList.hydrate({
            self.tableView.reloadData()
        })
    }
    
    /**
     * Callback whenver this view is focused
     */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    func renderTableView() -> Void {
        tableView.frame.origin.y = 60
        tableView.frame.size.width = self.view.frame.size.width
        tableView.frame.size.height = self.view.frame.size.height
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.layoutMargins = UIEdgeInsets.zero
        self.view.addSubview(tableView)
    }
    
    func renderNewField() -> Void {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 110)
        view.backgroundColor = UIColor.white
        textField.frame = CGRect(x: 0, y: 70, width: 200, height: 40)
        textField.backgroundColor = UIColor.white
        textField.placeholder = "Add a city"
        textField.borderStyle = UITextBorderStyle.line
        view.addSubview(textField)
        self.view.addSubview(view)
    }
    
    func renderNewButton() -> Void {
        let button: UIButton = UIButton(frame: CGRect(x: 210, y: 70, width: 60, height: 40))
        button.backgroundColor = UIColor.blue
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("Add", for: .normal)
        button.addTarget(self, action: #selector(MainViewController.newButtonPressed), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    /**
     * Click handler for add new city button
     */
    func newButtonPressed() -> Void {
        self.locationList.addNewLocation(textField.text!, { list in
            self.textField.text = ""
            self.tableView.reloadData()
        })
    }
    
    /**
     * Implement tableView numberOfRowsInSection
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locationList.list.count
    }
    
    /**
     * Implement tableView cellForRow
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        let location = self.locationList.list[indexPath.row]
        
        cell.imageView!.image = location.image
        cell.textLabel?.text = "\(location.city) \(location.temperature!)\u{00B0}"
        
        return cell
    }
    
    /**
     * Implement tableView didSelectRow
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) -> Void {
        let location = self.locationList.list[indexPath.row]
        self.locationList.viewLocation(location, {
            self.tableView.reloadData()
            let detailViewController:DetailViewController = DetailViewController(location, self.locationList)
            self.navigationController?.pushViewController(detailViewController, animated: true)
        })
    }
    
}
