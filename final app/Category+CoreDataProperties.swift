//
//  Category+CoreDataProperties.swift
//  final app
//
//  Created by DuyLinh on 5/10/16.
//  Copyright © 2016 DuyLinh. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Category {

    @NSManaged var categoriesName: String?
    @NSManaged var lists: NSSet?
    
    
    func addList(value: List)
    {
        let lis = self.mutableSetValueForKey("lists")
        lis.addObject(value)
    }
    
    
    func getList() -> [List] {
        var lists: [List]
        lists = self.lists!.allObjects as! [List]
        return lists
    }


}
