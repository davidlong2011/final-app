//
//  User.swift
//  final app
//
//  Created by DuyLinh on 5/6/16.
//  Copyright © 2016 DuyLinh. All rights reserved.
//

import Foundation
import CoreData


class User: NSManagedObject {
    
    func addCategory(value: Category)
    {
        let lis = self.mutableSetValueForKey("categories")
        lis.addObject(value)
    }
    
    
    func getCategories() -> [Category] {
        var categories: [Category]
        categories = self.categories!.allObjects as! [Category]
        return categories
    }


// Insert code here to add functionality to your managed object subclass

}
