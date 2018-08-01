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
    
    @IBAction func standardizedTestingButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "enterStandarizedTestingScore", sender: self)
    }
    
    @IBAction func stateButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "stateSegue", sender: self)
    }
    
    @IBAction func collegeNameButtonPressed(_ sender: UIButton) {
        print("only standardized testing button has been implemented so far")
    }
    
}
