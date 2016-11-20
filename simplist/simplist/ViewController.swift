//
//  ViewController.swift
//  simplist
//
//  Created by Rob Osorio on 11/17/16.
//  Copyright © 2016 Rob Osorio. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBAction func loginButton(sender: AnyObject) {
        
    }
    var loggedInUser = "";
    @IBAction func registerButton(sender: AnyObject) {
        FIRAuth.auth()?.createUserwithEmail (username.text!, password: password.text!) { (user, error) in
            // ...
        }
    }
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ref = FIRDatabase.database().referenceWithPath("grocery-items")
        print(ref.key)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

