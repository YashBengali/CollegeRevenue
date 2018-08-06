//
//  DisplayColleges.swift
//  CollegeRevenue
//
//  Created by Yash on 7/27/18.
//  Copyright © 2018 Yash. All rights reserved.
//

import Foundation
import UIKit

class DisplayColleges: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    let fileName: String = "CSVRec"
    let filePrefix: String = "csv"
    var colleges: [String] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    var currentIndexPath: NSIndexPath?
    override func viewDidLoad() {
        //print("hello")
        readText()
    }
    
    func readText() {
        //print("-------READ TEXT---------")

        let file = "CSVRec.csv" //this is the file. we will write to and read from it
       // let text = "some text" //just a text
        //print("reading the list of colleges")
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
            print("\n\nreading from locsation: \(fileURL)")
            //reading
            do {
                let contentString = try String(contentsOf: fileURL, encoding: .utf8)
                let parsedCSV: [[String]] = contentString.components(separatedBy: "\n").map{ $0.components(separatedBy: ",") }
              //  print(parsedCSV)
                colleges = parsedCSV[0]
            }
            catch {/* error handling here */}
        }
    }
    
    // PRINTING THE COLLEGES TO THE SCREEN IN THE TABLEVIEW

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("-------NUMBEROFROWS IN SECTION---------")

        return colleges.count
    }
    // this is not called
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print("-------TABLE VIEW FOR ROW AT CALLED---------")
        //let cell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: cell.)
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! UITableViewCell
        cell.textLabel?.text = colleges[indexPath.item]
        cell.isUserInteractionEnabled = true
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("in")
//    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let id = segue.identifier else { return }
//        if id == "collegeClicked" {
//            print("hi")
//        }
//    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("-------PREPARE CALLED---------")
        guard let indexPath = tableView.indexPathForSelectedRow else{return}
        let index = indexPath.row
        let collegeNameToPass = colleges[index]
        //let note = notes[indexPath.row]
//        let destination = segue.destination as! DisplayNoteViewController
//        destination.note = note
        
        if segue.identifier == "collegeClicked" {
            if let destination = segue.destination as?  CollegeInformation{
                destination.collegeNamePassedIn = collegeNameToPass
            }
        }
    }
    
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue) {
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("i'm seloected")
//    }
    
}
