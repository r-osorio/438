//
//  DetailViewController.swift
//  simplist
//
//  Created by Rob Osorio on 12/4/16.
//  Copyright © 2016 Rob Osorio. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var theLabel: UILabel!
    
    @IBOutlet weak var theIngredientTableView: UITableView!
    
    let ref = FIRDatabase.database().referenceWithPath("ingredient-list")
    var items = [FIRDataSnapshot]()
    var name: String = ""
    var size: Int!
    //var ingredientData = [FIRDataSnapshot]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        theIngredientTableView.delegate = self
        theIngredientTableView.dataSource = self
        theIngredientTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")

        // Do any additional setup after loading the view.
        ref.observeEventType(.Value) { (snapshot: FIRDataSnapshot!) in
            
            var newItems = [FIRDataSnapshot]()
            
            // loop through the children and append them to the new array
            for item in snapshot.children {
                //print(item.children.allObjects[1].children.allObjects[0])
                newItems.append(item as! FIRDataSnapshot)
            }
            // replace the old array
            self.items = newItems
            // reload the UITableView
            self.theIngredientTableView.reloadData()
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        theLabel.text = name

        
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let c = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        var i = 0
        for event in self.items {
            if(event.key == name) {
                break
            }
            i += 1
        }
        print("key")
        let key = self.items[i].value?.allObjects[indexPath.row]["name"].description
        print (key)
        print("value")
        let value = self.items[i].value?.allObjects[indexPath.row]["broughtBy"].description
        print(value)
        //print (self.items[i].value?.valueForKey(key as? String))
        c.textLabel!.text = (key as String!) + ", brought by " + (value as String!)

        return c
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.items)
        var c = self.items.count
        if (c >= 1) {
            var i = 0
            for event in self.items {
                if (event.key == name) {
                    break
                }
                i += 1
            }
            c = self.items[i].value!.allObjects.count
        }
        return c
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print ("you clicked on:")
        print(indexPath.row)
        var i = 0
        for event in self.items {
            if(event.key == name) {
                break
            }
            i += 1
        }
        let nodeRef = FIRDatabase.database().referenceWithPath("ingredient-list/\(name)/\(indexPath.row)")
        nodeRef.updateChildValues(["broughtBy": sessionUN])
        //let ingredientName = self.items[i].value?.allObjects[indexPath.row]["name"].description
        //let ingredientBroughtBy = self.items[i].value?.allObjects[indexPath.row]["broughtBy"]
        //let key = self.items[i].value?.allObjects[indexPath.row]["name"].description as String!
        //let ref = self.items[i].value?.ref.parent//.child("\(key)")
        //print(ref?.description())
        //ref?.updateChildValues(["broughtBy": sessionUN])
//        var update = [[String: String]]()
//        update.append([
//            "name": ingredientName!,
//            "broughtBy": sessionUN
//        ])
//        var childUpdates = [[FIRDatabaseReference: [[String: String]]]]()
//        childUpdates.append([key!: update])
        //key?.updateChildValues(["broughtByyyy": sessionUN])
        
        //let cell = self.items.
        //let reference = cell?.ref
//        reference.update(cell + "(" + sessionUN + ")")
//        AHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH FIXXXXXXXXXXXXX MMEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
//        print(cell.value)
        //print(self.items.child(name))
//        let detailVC = storyboard?.instantiateViewControllerWithIdentifier("detailVC") as? DetailViewController
//        detailVC?.name = self.items[indexPath.row].value!["name"].description
//        
//        self.navigationController?.pushViewController(detailVC!, animated: true)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
