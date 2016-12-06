//
//  Ingredient.swift
//  simplist
//
//  Created by Rob Osorio on 12/5/16.
//  Copyright © 2016 Rob Osorio. All rights reserved.
//

import UIKit

class Ingredient: NSObject {

    var Name: String!
    var BroughtBy: String!
    
    init(name: String, broughtBy: String) {
        self.Name = name
        self.BroughtBy = broughtBy
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "ingredientName": Name,
            "broughtBy": BroughtBy
        ]
    }
    
}
