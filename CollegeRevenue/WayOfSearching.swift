//
//  WayOfSearching.swift
//  CollegeRevenue
//
//  Created by Yash on 7/31/18.
//  Copyright © 2018 Yash. All rights reserved.
//

import Foundation
import UIKit

class WayOfSearching: UIViewController {
    
    @IBOutlet weak var standardizedTestingButton: UIButton!
    @IBOutlet weak var collegeNameButton: UIButton!
    @IBOutlet weak var stateButton: UIButton!
    @IBAction func standardizedTestingButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "enterStandarizedTestingScore", sender: self)
    }
    
    @IBAction func stateButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "stateSegue", sender: self)
    }
    
    @IBAction func collegeNameButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "swapToPickingState", sender: self)
    }
    
    override func viewDidLoad() {
        // background of the view controller
        view.backgroundColor = UIColor.darkGray
        
        // standarized testing button
        standardizedTestingButton.backgroundColor = .clear
        standardizedTestingButton.layer.cornerRadius = 5
        standardizedTestingButton.layer.borderWidth = 1
        standardizedTestingButton.layer.borderColor = UIColor.black.cgColor
        standardizedTestingButton.backgroundColor = UIColor.white
        
        // college name button
        collegeNameButton.backgroundColor = .clear
        collegeNameButton.layer.cornerRadius = 5
        collegeNameButton.layer.borderWidth = 1
        collegeNameButton.layer.borderColor = UIColor.black.cgColor
        
        // state button
        stateButton.backgroundColor = .clear
        stateButton.layer.cornerRadius = 5
        stateButton.layer.borderWidth = 1
        stateButton.layer.borderColor = UIColor.black.cgColor
    }
   

    
}
