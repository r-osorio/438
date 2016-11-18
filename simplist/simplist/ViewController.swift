//
//  ViewController.swift
//  simplist
//
//  Created by Rob Osorio on 11/17/16.
//  Copyright © 2016 Rob Osorio. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    let ref = FIRDatabase.database().reference(withPath: "grocery-items")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

