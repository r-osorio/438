//
//  NewEvent.swift
//  simplist
//
//  Created by Sophia Veksler on 11/20/16.
//  Copyright © 2016 Rob Osorio. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class NewEvent: UIViewController {
    @IBOutlet weak var eventName: UITextField!
    @IBOutlet weak var eventDate: UIDatePicker!
    @IBOutlet weak var eventGuests: UITextField!
    @IBOutlet weak var eventIngredients: UITextField!
    @IBAction func createButton(sender: AnyObject) {
        let newGuests = "" + sessionUN + "," + eventGuests.text!
        let newEvent = Event(name: eventName.text!, date: eventDate.date, guests: newGuests, host: sessionUN)
        let databaseRef = FIRDatabase.database().referenceWithPath("event-list")
        let eventInDatabaseRef = databaseRef.child(eventName.text!)
        let ingredientsList = eventIngredients.text!.componentsSeparatedByString(",")
        var ingredientsArray = [[String: String]]()
        for i in ingredientsList {
            ingredientsArray.append(["name": i, "broughtBy": "None"])
        }
        let databaseRef2 = FIRDatabase.database().referenceWithPath("ingredient-list")
        let eventInDatabaseRef2 = databaseRef2.child(eventName.text!)
        eventInDatabaseRef2.setValue(ingredientsList)
        eventInDatabaseRef.setValue(newEvent.toAnyObject())
    }

}
