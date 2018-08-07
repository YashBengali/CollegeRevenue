//
//  StateSelectionViewController.swift
//  CollegeRevenue
//
//  Created by Yash on 7/31/18.
//  Copyright © 2018 Yash. All rights reserved.
//

import Foundation
import UIKit

class StateSelectionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    
    
    var colleges: [String] = []
    let fileName: String = "college_data_main"
    let filePrefix: String = "csv"
    var collegeIndex: Int = 1
    var filteredData = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var isSearching = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "collegesToDisplay")
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        readText()
//        [self.searchDisplayController.searchResultsTableView registerClass:[TableViewCell class]
//            forCellReuseIdentifier:@"IdentifierForCell"];
//
//        searchBar.searchRes
        
        
    }
    
    func readText() {
        let path = Bundle.main.path(forResource: fileName, ofType: filePrefix)
        
        let url = URL(fileURLWithPath: path!)
        // ARRAY WITH THE NAME OF CDLLEGES
        let contentString = try! NSString(contentsOf: url, encoding: String.Encoding.utf8.rawValue)
        let parsedCSV: [[String]] = contentString.components(separatedBy: "\n").map{ $0.components(separatedBy: ",") }
        // the 1 makes the count start from 1.
        var college: [String] = []
        for index in 1..<parsedCSV.count {
            college = parsedCSV[index]
            colleges.append(college[collegeIndex])
        }
      // print(colleges)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching {
            return filteredData.count
        }
        return colleges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // adding self. fixed it
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "collegesToDisplay", for: indexPath)
        cell.textLabel?.text = colleges[indexPath.item]
        cell.isUserInteractionEnabled = true
        
        if isSearching {
            cell.textLabel?.text = filteredData[indexPath.row]
        }
        
        return cell
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
        }
        else {
            isSearching = true
            // $0 == searchBar.text searches for exact name. Ex: harvard dosent work but
            filteredData = colleges.filter({$0.range(of:searchBar.text!) != nil})
        }
        
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("---- in did select row at-----")
//        performSegue(withIdentifier: "swapToDisplayCollege", sender: self)
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //print("-------PREPARE CALLED---------")
        guard let indexPath = tableView.indexPathForSelectedRow else{return}
        let index = indexPath.row
        let collegeNameToPass = colleges[index]
        //let note = notes[indexPath.row]
        //        let destination = segue.destination as! DisplayNoteViewController
        //        destination.note = note

        if segue.identifier == "swapToDisplayCollege" {
            if let destination = segue.destination as?  CollegeInformation{
                destination.collegeNamePassedIn = collegeNameToPass
            }
        }
    }
}
