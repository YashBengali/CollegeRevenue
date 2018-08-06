//
//  StateSearchViewController.swift
//  CollegeRevenue
//
//  Created by Yash on 8/2/18.
//  Copyright © 2018 Yash. All rights reserved.
//

import Foundation
import UIKit

class PickState: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var collegeReccomendations: [String] = []
    var finalSatScore: Int = 0
    let satScoreIndex: Int = 6
    let collegeNameIndex: Int = 1
    let actScoreIndex: Int = 29
    let fileName: String = "college_data_main"
    let filePrefix: String = "csv"
    let collegeStateIndex: Int = 3

    var listOfStateNames: [String] = ["Alabama",
                                      "Alaska",
                                      "Arizona",
                                      "Arkansas",
                                      "California",
                                      "Colorado",
                                      "Connecticut",
                                      "Delaware",
                                      "Florida",
                                      "Georgia",
                                      "Hawaii",
                                      "Idaho",
                                      "Illinois",
                                      "Indiana",
                                      "Iowa",
                                      "Kansas",
                                      "Kentucky",
                                      "Louisiana",
                                      "Maine",
                                      "Maryland",
                                      "Massachusetts",
                                      "Michigan",
                                      "Minnesota",
                                      "Mississippi",
                                      "Missouri",
                                      "Montana",
                                      "Nebraska",
                                      "Nevada",
                                      "New Hampshire",
                                      "New Jersey",
                                      "New Mexico",
                                      "New York",
                                      "North Carolina",
                                      "North Dakota",
                                      "Ohio",
                                      "Oklahoma",
                                      "Oregon",
                                      "Pennsylvania",
                                      "Rhode Island",
                                      "South Carolina",
                                      "South Dakota",
                                      "Tennessee",
                                      "Texas",
                                      "Utah",
                                      "Vermont",
                                      "Virginia",
                                      "Washington",
                                      "West Virginia",
                                      "Wisconsin",
                                      "Wyoming"]
    
    
    var listOfStateAbbreviations: [String] = ["AL",
                                              "AK",
                                              "AZ",
                                              "AR",
                                              "CA",
                                              "CO",
                                              "CT",
                                              "DE",
                                              "FL",
                                              "GA",
                                              "HI",
                                              "ID",
                                              "IL",
                                              "IN",
                                              "IA",
                                              "KS",
                                              "KY",
                                              "LA",
                                              "ME",
                                              "MD",
                                              "MA",
                                              "MI",
                                              "MN",
                                              "MS",
                                              "MO",
                                              "MT",
                                              "NE",
                                              "NV",
                                              "NH",
                                              "NJ",
                                              "NM",
                                              "NY",
                                              "NC",
                                              "ND",
                                              "OH",
                                              "OK",
                                              "OR",
                                              "PA",
                                              "RI",
                                              "SC",
                                              "SD",
                                              "TN",
                                              "TX",
                                              "UT",
                                              "VT",
                                              "VA",
                                              "WA",
                                              "WV",
                                              "WI",
                                              "WY"]
    
    
    override func viewDidLoad() {
        // adding in these 3 lines made it work
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        print("hi")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("in the num of rows in section function \(listOfStateNames.count)")
        return 50
    }

    // this is not called
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! UITableViewCell
        print(indexPath.item)
        cell.textLabel?.text = listOfStateNames[indexPath.item]
        cell.isUserInteractionEnabled = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let indexPath = tableView.indexPathForSelectedRow else{return}
        let index = indexPath.row
        let statesToPass = listOfStateAbbreviations[index]
        readText(statesToPass: statesToPass)
        performSegue(withIdentifier: "hi", sender: self)
    }
    
    
    func readText(statesToPass: String) {
        let path = Bundle.main.path(forResource: fileName, ofType: filePrefix)
        
        let url = URL(fileURLWithPath: path!)
        // ARRAY WITH THE NAME OF CDLLEGES
        var collegeName: [String] = []
        let contentString = try! NSString(contentsOf: url, encoding: String.Encoding.utf8.rawValue)
        let parsedCSV: [[String]] = contentString.components(separatedBy: "\n").map{ $0.components(separatedBy: ",") }
        // the 1 makes the count start from 1.
        var college: [String] = []
        var state: [String] = []
        for index in 1..<parsedCSV.count {
            college = parsedCSV[index]
            print(college)
            state.append(college[collegeStateIndex])
            collegeName.append(college[collegeNameIndex])
        }
        // COLLEGE NAMES WITHOUT NULL VALUES FOR THE SAT SCORE
        var collegeWithState: [String] = []
        //print(collegeName)
        var stateWithoutNull: [String] = []
        var counter = 0
        for item in state {
            
            if item != "NULL" {
                stateWithoutNull.append(item)
                collegeWithState.append(collegeName[counter])
                
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
        
        var currentItem: String?
        for item in stateWithoutNull {
            currentItem = item
            if currentItem == statesToPass {
                collegeReccomendations.append(collegeWithState[temporaryCounter])
            }
            temporaryCounter+=1
        }
        print(collegeReccomendations)
        //print(collegeReccomendations)
        let finalCollegeReccomendations: String = convertArrayToString(array: collegeReccomendations)
        //let finalCollegeName: String = convertArrayToString(array: collegeWithSat)
        createCSV(input: finalCollegeReccomendations)
        //testingApi()
        
    }
    
    
    func createCSV(input: String) {
        // let csvString = "hello"
        print("-----------------INSIDE THE CREATE CSV FUNCTION------------------")
        print(input)
        let csvString  = input
        let fileManager = FileManager.default
        do {
            let path = try fileManager.url(for: .documentDirectory, in: .allDomainsMask, appropriateFor: nil, create: false)
            //            print("PRINTING OUT THE PATH NOW ******************")
            //            print(path)
            let fileURL = path.appendingPathComponent("CSVRec.csv")
            //            print("PRINTING OUT THE file url NOW ******************")
            //            print(fileURL)
            
            do {
                try fileManager.removeItem(atPath: "CSVRec.csv")
            }
            catch let error as NSError {
            }
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

    
}
