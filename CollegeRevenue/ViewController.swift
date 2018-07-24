//
//  ViewController.swift
//  CollegeRevenue
//
//  Created by Yash on 7/23/18.
//  Copyright © 2018 Yash. All rights reserved.
//

import UIKit
import GoogleSignIn


class ViewController: UIViewController, GIDSignInUIDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(sign(_:)), name: NSNotification.Name(rawValue: "userDidSignInSuccessfully"), object: nil)
        
       // GIDSignIn.sharedInstance().signIn()
        
        // TODO(developer) Configure the sign-in button look/feel
        // ...
    }

    @objc func sign(_ notification: Notification) {
       
            self.performSegue(withIdentifier: "goToHomeScreen", sender: self)
        
        
    }
    


}

