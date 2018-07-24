//
//  Act.swift
//  CollegeRevenue
//
//  Created by Yash on 7/24/18.
//  Copyright © 2018 Yash. All rights reserved.
//

import Foundation
import UIKit

class Act: UIViewController {
    @IBOutlet weak var actGrammarScore: UITextField!
    @IBOutlet weak var actMathScore: UITextField!
    @IBOutlet weak var actReadingScore: UITextField!
    @IBOutlet weak var actScienceScore: UITextField!
    
    
    @IBAction func actScoreSent(_ sender: UIButton) {
        
        if let math=actMathScore.text{
            if let reading = actReadingScore.text {
                if let grammar = actGrammarScore.text {
                    if let science = actScienceScore.text {
                        let mathAsDouble = (math as NSString).doubleValue
                        let readingAsDouble = (reading as NSString).doubleValue
                        let grammarAsDouble = (grammar as NSString).doubleValue
                        let scienceAsDouble = (science as NSString).doubleValue
                        let added: Double = mathAsDouble+readingAsDouble+scienceAsDouble+grammarAsDouble
                        var average: Double = added/4
                        average = round(average)
                        print(average)
                    }
                }
               
            }
        }
    }
    
}
