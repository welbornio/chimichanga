//
//  MainViewController.swift
//  chimichanga
//
//  Created by shake on 9/13/16.
//  Copyright © 2016 welbornio. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(textField)
        view.addSubview(addCityBtn)
    }
    
    func buttonPressed() {
        weatherApi.getPopulatedList { list in
            print(list)
        }
    }
    
    let weatherApi = WeatherApi()
    
    lazy var textField: UITextField! = {
        let view = UITextField()
        view.frame = CGRectMake(50, 70, 200, 30)
        view.backgroundColor = UIColor.grayColor()
        return view
    }()
    
    lazy var addCityBtn: UIButton! = {
        let view = UIButton()
        view.addTarget(self, action: #selector(MainViewController.buttonPressed), forControlEvents: .TouchDown)
        view.setTitle("Add City", forState: .Normal)
        view.backgroundColor = UIColor.blueColor()
        view.frame = CGRectMake(100, 100, 100, 50)
        view.setTitle("Button", forState: UIControlState.Normal)
        
        return view
    }()
    
}
