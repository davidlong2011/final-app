//
//  ListItem+CoreDataProperties.swift
//  
//
//  Created by DuyLinh on 5/23/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension ListItem {

    @NSManaged var listItemName: String?
    @NSManaged var listItemDesc: String?
    @NSManaged var listItemDate: NSDate?
    @NSManaged var photos: NSSet?

}
