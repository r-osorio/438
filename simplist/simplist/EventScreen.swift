//
//  EventScreen.swift
//  simplist
//
//  Created by Sophia Veksler on 11/20/16.
//  Copyright © 2016 Rob Osorio. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class EventScreen: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var t: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        t = UITableView(frame: view.frame.offsetBy(dx:0, dy: 65))
        t.delegate = self
        t.dataSource = self
        t.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(t)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let c = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        //c.textLabel!.text = favs[indexPath.row] as String
        return c
        }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let c = 1
        //let c = favs.count
        return c
    }
    

}
