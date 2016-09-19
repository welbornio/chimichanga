//
//  DetailViewController.swift
//  chimichanga
//
//  Created by shake on 9/18/16.
//  Copyright © 2016 welbornio. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    var location :Location
    var locationList :LocationList
    
    /**
     * Initializer for DetailViewController
     */
    init(_ location: Location, _ locationList: LocationList) {
        self.location = location
        self.locationList = locationList
        super.init(nibName: nil, bundle: nil)
    }
    
    /**
     * Required initializer for UIViewController subclass
     */
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     * Post view load
     */
    override func viewDidLoad() -> Void {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        renderCityName()
        renderWeatherIcon()
        renderCurrentTemperature()
        renderHighTemperature()
        renderLowTemperature()
        renderRemoveButton()
    }
    
    func renderCityName() -> Void {
        let textView = UILabel()
        
        textView.font = UIFont(name: textView.font.fontName, size: 20)
        textView.text = "\(self.location.city)"
        textView.numberOfLines = 0
        textView.sizeToFit()
        textView.textColor = UIColor.black
        textView.frame = CGRect(x: 60, y: 70, width: self.view.frame.width - 100, height: textView.frame.height)
        
        self.view.addSubview(textView)
    }
    
    func renderWeatherIcon() -> Void {
        let image = UIImageView(image: self.location.image)
        image.frame = CGRect(x: 0, y: 60, width: self.location.image!.size.width, height: self.location.image!.size.height)
        self.view.addSubview(image)
    }
    
    func renderCurrentTemperature() -> Void {
        let textView = UILabel(frame: CGRect(x: 0, y: 100, width: self.view.frame.width, height: 20))
        textView.textColor = UIColor.black
        textView.text = "Current Temperature: \(self.location.temperature!)\u{00B0}"
        self.view.addSubview(textView)
    }
    
    func renderHighTemperature() -> Void {
        let textView = UILabel(frame: CGRect(x: 0, y: 120, width: self.view.frame.width, height: 20))
        textView.textColor = UIColor.black
        textView.text = "High: \(self.location.temperatureMax!)\u{00B0}"
        self.view.addSubview(textView)
    }
    
    func renderLowTemperature() -> Void {
        let textView = UILabel(frame: CGRect(x: 0, y: 140, width: self.view.frame.width, height: 20))
        textView.textColor = UIColor.black
        textView.text = "Low: \(self.location.temperatureMin!)\u{00B0}"
        self.view.addSubview(textView)
    }
    
    func renderRemoveButton() -> Void {
        let button: UIButton = UIButton(frame: CGRect(x: 0, y: 160, width: 150, height: 40))
        button.backgroundColor = UIColor.red
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("Remove Location", for: .normal)
        button.addTarget(self, action: #selector(DetailViewController.removeButtonPressed), for: .touchUpInside)
        
        self.view.addSubview(button)
    }
    
    /**
     * Remove button click handler
     */
    func removeButtonPressed() {
        self.locationList.removeLocation(self.location, {
            self.navigationController?.popViewController(animated: true)
        })
    }
}
