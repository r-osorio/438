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
    //var ingredientData = [FIRDataSnapshot]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        theIngredientTableView.delegate = self
        theIngredientTableView.dataSource = self
        theIngredientTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        theLabel.text = name
        
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
            //print(self.items)
            self.theIngredientTableView.reloadData()
            
        }

        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let c = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        print ("self.items['indexpath.row'].key = ")
        print (self.items[indexPath.row].key)
        var i = 0
        var eventIndex = 0
        for element in self.items{
            //print (element.value)
            if (element.key == name) {
                eventIndex = i
                //c.textLabel!.text = element.children.allObjects[indexPath.row].value
            }
            i += 1
        }
        c.textLabel!.text = self.items[eventIndex].children.allObjects[indexPath.row].value //{
//            print("!!!")
//            print(element.description)
//            c.textLabel!.text = element.description
//        }
        return c
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let c = items.count
        return c
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print ("you clicked on:")
        print(indexPath.row)
        var i = 0
        var eventIndex = 0
        for element in self.items {
            if (element.key == name) {
                eventIndex = i
            }
            i += 1
        }
        let cell = self.items[eventIndex].children.allObjects[indexPath.row] as? FIRDataSnapshot
        let reference = cell?.ref
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
