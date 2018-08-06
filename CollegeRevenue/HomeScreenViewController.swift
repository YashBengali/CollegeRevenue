//
//  HomeScreenViewController.swift
//  CollegeRevenue
//
//  Created by Yash on 7/24/18.
//  Copyright © 2018 Yash. All rights reserved.
//

import Foundation
import UIKit

class HomeScreenViewController: UIViewController {
    @IBOutlet weak var satButton: UIButton!
    @IBOutlet weak var actButton: UIButton!
    
    
    @IBAction func satButtonPressed(_ sender: UIButton) {
        print("SAT Button Pressed")
        self.performSegue(withIdentifier: "goToSat", sender: self)
    }
    
    @IBAction func actButtonPressed(_ sender: UIButton) {
        print("ACT Button Pressed")
        self.performSegue(withIdentifier: "goToAct", sender: self)
    }
    @IBAction func unwindWindToSatAndAct(_ segue: UIStoryboardSegue) {
    }
   
}
