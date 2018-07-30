//
//  Sat.swift
//  CollegeRevenue
//
//  Created by Yash on 7/24/18.
//  Copyright © 2018 Yash. All rights reserved.
//

import Foundation
import UIKit
import GoogleAPIClientForREST
import MobileCoreServices

class Sat: UIViewController {
    
    
    
    @IBOutlet weak var satMathScore: UITextField!
    @IBOutlet weak var satReadingScore: UITextField!
    var collegeReccomendations: [String] = []
    var finalSatScore: Int = 0
    let satScoreIndex: Int = 28
    let collegeNameIndex: Int = 3
    let actScoreIndex: Int = 29
    let fileName: String = "college_summary"
    let filePrefix: String = "csv"
    //var collegeReccomendations: [String] = []
    @IBAction func satScoreSent(_ sender: UIButton) {
        if let math=satMathScore.text{
            if let reading = satReadingScore.text {
               let mathAsInt = (math as NSString).integerValue
               let readingAsInt = (reading as NSString).integerValue
                print(mathAsInt+readingAsInt)
                finalSatScore = mathAsInt+readingAsInt
                readText()
                changeViewControlllers()
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
        for index in 1..<parsedCSV.count {
            college = parsedCSV[index]
            satScore.append(college[satScoreIndex])
            collegeName.append(college[collegeNameIndex])
        }
        // COLLEGE NAMES WITHOUT NULL VALUES FOR THE SAT SCORE
        var collegeWithSat: [String] = []
       //print(collegeName)
        var satScoreWithoutNull: [String] = []
        var counter = 0
        for item in satScore {
            
            if item != "NULL" {
                satScoreWithoutNull.append(item)
                collegeWithSat.append(collegeName[counter])
                
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
        
        let satRangeLow = finalSatScore-50
        let satRangeHigh = finalSatScore+50
        var currentItem: Int?
        for item in satScoreWithoutNull {
            currentItem = Int(item)
            if ((currentItem! > satRangeLow) && (currentItem! < satRangeHigh)) {
                collegeReccomendations.append(collegeWithSat[temporaryCounter])
            }
            temporaryCounter+=1
        }
        //print(collegeReccomendations)
        let finalCollegeReccomendations: String = convertArrayToString(array: collegeReccomendations)
        //let finalCollegeName: String = convertArrayToString(array: collegeWithSat)
        createCSV(input: finalCollegeReccomendations)
        //testingApi()

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
  
    func changeViewControlllers(){
        self.performSegue(withIdentifier: "swapToDisplayingCollege", sender: nil)
    }
    
    func returnCollegeList() -> [String] {
        print("in the return college list function")
        print(collegeReccomendations)
        return collegeReccomendations
    }
    
    
}
