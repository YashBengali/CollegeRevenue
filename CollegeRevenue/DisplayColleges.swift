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
    var currentIndexPath: NSIndexPath?
    override func viewDidLoad() {
        print("hello")
        readText()
    }
    
    func readText() {
        let file = "CSVRec.csv" //this is the file. we will write to and read from it
       // let text = "some text" //just a text
        print("IN THE DMS")
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
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
        return colleges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: cell.)
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! UITableViewCell
        cell.textLabel?.text = colleges[indexPath.item]
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("in")
//    }
    
//    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == localPostsDetailSegue {
//            if let destination = segue.destinationViewController as? LocalPostsDetailViewController {
//                destination.postName.text! = names[currentIndexPath.row]
//            }
//        }
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print("hi")
    }
    
}
