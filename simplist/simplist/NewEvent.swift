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
    @IBAction func createButton(sender: AnyObject) {
        let newEvent = Event(name: eventName.text!, date: eventDate.date, guests: eventGuests.text!)
        let databaseRef = FIRDatabase.database().referenceWithPath("event-list")
        let eventInDatabaseRef = databaseRef.child(eventName.text!)
        eventInDatabaseRef.setValue(newEvent.toAnyObject())
    }

}
