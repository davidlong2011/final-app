//
//  User+CoreDataProperties.swift
//  final app
//
//  Created by DuyLinh on 5/6/16.
//  Copyright © 2016 DuyLinh. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension User {

    @NSManaged var userName: String?
    @NSManaged var userPassword: String?

}
