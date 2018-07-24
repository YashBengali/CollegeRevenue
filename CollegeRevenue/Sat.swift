//
//  Sat.swift
//  CollegeRevenue
//
//  Created by Yash on 7/24/18.
//  Copyright © 2018 Yash. All rights reserved.
//

import Foundation
import UIKit

class Sat: UIViewController {
    
    @IBOutlet weak var satMathScore: UITextField!
    @IBOutlet weak var satReadingScore: UITextField!
    
    @IBAction func satScoreSent(_ sender: UIButton) {
        if let math=satMathScore.text{
            if let reading = satReadingScore.text {
               let mathAsInt = (math as NSString).integerValue
               let readingAsInt = (reading as NSString).integerValue
                print(mathAsInt+readingAsInt)
            }
        }
        
    }
    
}
