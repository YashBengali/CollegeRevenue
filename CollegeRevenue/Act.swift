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
    var collegeReccomendations: [String] = []
    var finalSatScore: Int = 0
    let satScoreIndex: Int = 6
    let collegeNameIndex: Int = 1
    let actScoreIndex: Int = 5
    let fileName: String = "college_data_main"
    let filePrefix: String = "csv"
    let collegeStateIndex: Int = 3
    var userActScore: Int = 0
    
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
                        userActScore = Int(average)
                        readText()
                        changeViewControllers()
                    }
                }
               
            }
        }
    }
    
    func readText() {
        let path = Bundle.main.path(forResource: fileName, ofType: filePrefix)
        
        let url = URL(fileURLWithPath: path!)
        // ARRAY WITH THE NAME OF CDLLEGES
        var collegeName: [String] = []
        let contentString = try! NSString(contentsOf: url, encoding: String.Encoding.utf8.rawValue)
        let parsedCSV: [[String]] = contentString.components(separatedBy: "\n").map{ $0.components(separatedBy: ",") }
        // the 1 makes the count start from 1.
        var college: [String] = []
        var satScore: [String] = []
        var act: [String] = []
        for index in 1..<parsedCSV.count {
            college = parsedCSV[index]
            print(college)
            satScore.append(college[satScoreIndex])
            collegeName.append(college[collegeNameIndex])
            act.append(college[actScoreIndex])
        }
        // COLLEGE NAMES WITHOUT NULL VALUES FOR THE SAT SCORE
        var collegeWithSat: [String] = []
        //print(collegeName)
        var satScoreWithoutNull: [String] = []
        var counter = 0
        // ACT SCORE FOR COLLEGES
        var finalActScore: [String] = []
        for item in act {
            
            if item != "NULL" {
                satScoreWithoutNull.append(item)
                collegeWithSat.append(collegeName[counter])
                finalActScore.append(act[counter])
            }
            counter+=1
        }
        //  print(collegeWithSat)
        
        
        
        // look through the array and find the correspoding college based on the sat score.
        //proper arrays satScoreWithoutNull and collegeWithSat
        // college with sat is the college name that has a correpsonding sat score and satScore without null is just a list
        // of the sat scores
        // collegeReccomendations is the list of colleges that I am going to reccomend to the user
        var temporaryCounter = 0
        
        //        var collegeReccomendations: [String] = []
        //        for item in satScoreWithoutNull {
        //            if (Int(item) == finalSatScore) {
        //                collegeReccomendations.append(collegeWithSat[temporaryCounter])
        //            }
        //            temporaryCounter+=1
        //        }
        //        print(collegeReccomendations)
        
//        let satRangeLow = finalSatScore-50
//        let satRangeHigh = finalSatScore+50
        let actRangeLow = userActScore-1
        let actRangeHigh = userActScore+1
        var currentItem: Int?
        for item in finalActScore {
            currentItem = Int(item)
            if ((currentItem! > actRangeLow) && (currentItem! < actRangeHigh)) {
                collegeReccomendations.append(collegeWithSat[temporaryCounter])
            }
            temporaryCounter+=1
        }
        //print(collegeReccomendations)
        let finalCollegeReccomendations: String = convertArrayToString(array: collegeReccomendations)
        //let finalCollegeName: String = convertArrayToString(array: collegeWithSat)
        createCSV(input: finalCollegeReccomendations)
        
    }
    
    
    func createCSV(input: String) {
        // let csvString = "hello"
        let csvString  = input
        let fileManager = FileManager.default
        do {
            let path = try fileManager.url(for: .documentDirectory, in: .allDomainsMask, appropriateFor: nil, create: false)
            //            print("PRINTING OUT THE PATH NOW ******************")
            //            print(path)
            let fileURL = path.appendingPathComponent("CSVRec.csv")
            //            print("PRINTING OUT THE file url NOW ******************")
            //            print(fileURL)
            
            print(fileURL)
            try csvString.write(to: fileURL, atomically: true, encoding: .utf8)
            print("it wrote to the file")
            print(fileURL)
        } catch {
            print("error creating file")
        }
        
        
        
    }
    
    func convertArrayToString(array: [String]) -> String {
        var stringToReturn: String = ""
        for item in array {
            stringToReturn = stringToReturn + "," + item
        }
        stringToReturn.removeFirst()
        return stringToReturn
    }
    
    func changeViewControllers(){
        self.performSegue(withIdentifier: "actToCollegeDisplay", sender: nil)
    }
    
    func returnCollegeList() -> [String] {
        print("in the return college list function")
        print(collegeReccomendations)
        return collegeReccomendations
    }
    @IBAction func unwindToChoosingMethod(_ segue: UIStoryboardSegue) {
    }
    
}
