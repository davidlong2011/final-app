//
//  User+CoreDataProperties.swift
//  
//
//  Created by DuyLinh on 6/8/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension User {

    @NSManaged var signedIn: String?
    @NSManaged var userName: String?
    @NSManaged var userPassword: String?
    @NSManaged var profileImage: NSData?

}
