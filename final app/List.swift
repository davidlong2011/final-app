//
//  List.swift
//  final app
//
//  Created by DuyLinh on 5/5/16.
//  Copyright © 2016 DuyLinh. All rights reserved.
//

import Foundation
import CoreData


class List: NSManagedObject {

    func addListItem(value: ListItem)
    {
        let lis = self.mutableSetValueForKey("listItems")
        lis.addObject(value)
    }
    
    
    func getListItem() -> [ListItem] {
        var listItems: [ListItem]
        listItems = self.listItems!.allObjects as! [ListItem]
        return listItems
    }

}
