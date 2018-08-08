//
//  CollegeInformation.swift
//  CollegeRevenue
//
//  Created by Yash on 7/30/18.
//  Copyright © 2018 Yash. All rights reserved.
//

import Foundation
import UIKit

class CollegeInformation: UIViewController {
    
    @IBOutlet weak var collegeNameButton: UILabel!
    @IBOutlet weak var satLabel: UILabel!
    @IBOutlet weak var actLabel: UILabel!
    @IBOutlet weak var costButtonInState: UILabel!
    @IBOutlet weak var costButtonOutOfState: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var topSalaryLabel: UILabel!
    
    // this value will be set when the
    var parsedCSV: [[String]] = [[]]
    var college: [String] = []
    var satScore: [String] = []
    var collegeName: [String] = []
    var collegeNamePassedIn: String = ""
    var satScoreFromData: String = ""
    var actScoreFromData: String = ""
    var costOfAttendaceInState: String = ""
    var costOfAttendaceOutState: String = ""
    var salary: String = ""
    var highSalary: String = ""
    let fileName: String = "college_data_main"
    let filePrefix: String = "csv"
    let satScoreIndex: Int = 6
    let collegeNameIndex: Int = 1
    var collegeWithSat: [String] = []
    var satScoreWithoutNull: [String] = []
    var columnInList: Int = 0
    override func viewDidLoad() {
        collegeNameButton.text = collegeNamePassedIn
        readData()
        findCollegeStats()
    }
    
    
    func readData() {
        let path = Bundle.main.path(forResource: fileName, ofType: filePrefix)
        let url = URL(fileURLWithPath: path!)
        // ARRAY WITH THE NAME OF CDLLEGES
        
        let contentString = try! NSString(contentsOf: url, encoding: String.Encoding.utf8.rawValue)
        parsedCSV = contentString.components(separatedBy: "\n").map{ $0.components(separatedBy: ",") }
        // the 1 makes the count start from 1.
        
        for index in 1..<parsedCSV.count {
            college = parsedCSV[index]
            satScore.append(college[satScoreIndex])
            collegeName.append(college[collegeNameIndex])
        }
       
        // COLLEGE NAMES WITHOUT NULL VALUES FOR THE SAT SCORE
        
//        var counter = 0
//        for item in satScore {
//
//            if item != "NULL" {
//                satScoreWithoutNull.append(item)
//                collegeWithSat.append(collegeName[counter])
//
//            }
//            counter+=1
//        }
    }
    
    func findCollegeStats() {
        
        var namesOfCollegesWithoutRestOfData: [String] = []
        var tempCounter: Int = 0
        for college in collegeName {
            namesOfCollegesWithoutRestOfData.append(college)
            tempCounter = tempCounter + 1
        }
        //print(namesOfCollegesWithoutRestOfData)
        var count: Int = 0
        for college in namesOfCollegesWithoutRestOfData {
            if college == collegeNamePassedIn {
                columnInList = count
                //print("INSIDE THE LOOP AND COUNT IS \(count)")
            }
            count = count + 1
        }
        // need to add 1 because for some reason it counts the first line in the excel spreadsheet
        // that says what each column stands for
        var specificCollege: [String] = []
        specificCollege = parsedCSV[columnInList+1]
        satScoreFromData = specificCollege[6]
        actScoreFromData = specificCollege[5]
        costOfAttendaceInState = specificCollege[8]
        costOfAttendaceOutState = specificCollege[9]
        salary = specificCollege[10]
        highSalary = specificCollege[15]
        
        // setting values equal to the labels
        satLabel.text = satScoreFromData
        actLabel.text = actScoreFromData
        costButtonInState.text = "$" + costOfAttendaceInState
        costButtonOutOfState.text = "$" + costOfAttendaceOutState
        salaryLabel.text = "$" + salary
        topSalaryLabel.text = "$" + highSalary
    }
    

}
