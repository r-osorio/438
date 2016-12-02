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
    let ref = FIRDatabase.database().referenceWithPath("event-list")
    var items = [FIRDataSnapshot]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        t = UITableView(frame: view.frame.offsetBy(dx:0, dy: 65))
        t.delegate = self
        t.dataSource = self
        t.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(t)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        ref.observeEventType(.Value) { (snapshot: FIRDataSnapshot!) in
            
            var newItems = [FIRDataSnapshot]()
            
            // loop through the children and append them to the new array
            for item in snapshot.children {
                newItems.append(item as! FIRDataSnapshot)
            }
            // replace the old array
            self.items = newItems
            // reload the UITableView
            self.t.reloadData()
            print (self.items[0].children.allObjects[2])
            
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let c = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        var i = 0
        for element in self.items[indexPath.row].children.allObjects as! [FIRDataSnapshot] {
            if (i == 2) { //index 2 is the "name" index of each Event in firebase
                print(element.value)
                c.textLabel!.text = element.value as? String
            }
            i += 1
        }
        return c
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let c = items.count
        return c
    }
    

}
