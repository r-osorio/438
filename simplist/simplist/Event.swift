//
//  Event.swift
//  simplist
//
//  Created by Rob Osorio on 12/2/16.
//  Copyright © 2016 Rob Osorio. All rights reserved.
//

import UIKit

class Event: NSObject {
    var Name: String!
    var Date: NSDate!
    var Guests: [String]!
    var Host: String
    
    init(name: String, date: NSDate, guests: String, host: String) {
        self.Name = name
        self.Date = date
        self.Guests = guests.componentsSeparatedByString(",")
        self.Host = host
        super.init()
    }
    
    func toAnyObject() -> AnyObject {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy hh:mm:ss"
        return [
            "name": Name,
            "date": dateFormatter.stringFromDate(Date),
            "guests": Guests,
            "host": Host,
        ]
    }
    
}
