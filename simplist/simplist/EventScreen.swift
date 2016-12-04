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
                print("names")
                //print(item.children.allObjects[1].children.allObjects[0])
                let guests = item.value["guests"].description.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()).stringByReplacingOccurrencesOfString("\n", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil).stringByReplacingOccurrencesOfString("(", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil).stringByReplacingOccurrencesOfString(")", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()).stringByReplacingOccurrencesOfString("\"", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil).componentsSeparatedByString(",    ")
                print(guests)
                print(sessionUN)
                if (guests.contains(sessionUN)) {
                    print("added event")
                    newItems.append(item as! FIRDataSnapshot)
                }
                //FIXME: check if you are creator or attendee for event, if so, add it
                
            }
            // replace the old array
            self.items = newItems
            // reload the UITableView
            self.t.reloadData()
            
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print ("you clicked on something!")
        let detailVC = DetailViewController(nibName: "DetailedVC", bundle: nil)
        detailVC.name = self.items[indexPath.row].value!["name"].description
        navigationController?.pushViewController(detailVC, animated: true)
    }
    

}
