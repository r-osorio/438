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
    var user = "";
    
    @IBAction func loginButton(sender: AnyObject) {
        FIRAuth.auth()!.signInWithEmail(username.text!, password: password.text!) { (user, error) in
            if error == nil {
                self.user = self.username.text!
                print (self.user)
            }
        }
        
    }
    
    @IBAction func registerButton(sender: AnyObject) {
        FIRAuth.auth()!.createUserWithEmail(username.text!, password: password.text!, completion: {
            user, error in
            if error == nil {
                FIRAuth.auth()!.signInWithEmail(self.username.text!, password: self.password.text!) { (user, error) in
                    if error == nil {
                        self.user = self.username.text!
                        print (self.user)
                    }
                }
            }
        })
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

