//
//  ListItem.swift
//  final app
//
//  Created by DuyLinh on 5/5/16.
//  Copyright © 2016 DuyLinh. All rights reserved.
//

import Foundation
import CoreData


class ListItem: NSManagedObject {
    
    func addPhoto(value: Photo)
    {
        let photos = self.mutableSetValueForKey("photos")
        photos.addObject(value)
    }
    
    func getPhotos() -> [Photo] {
        var photos: [Photo]
        photos = self.photos!.allObjects as! [Photo]
        return photos
    }

    
    /*var title: String?
    var desc: String?
    var date: NSDate?
    
    
    init(newTitle: String ,newDescription:String , newDate : NSDate){
        title = newTitle
        desc = newDescription
        date = newDate
    }
    
    func getTitle() -> String
    {
        return self.title!
    }
    
    func getDesc() -> String
    {
        return self.desc!
    }
    func getDate() -> NSDate
    {
        return self.date!
    }
    
    func settitle(newTitle: String)
    {
        self.title = newTitle
    }
    
    func setdesc(newDesc: String)
    {
        self.desc = newDesc
    }
    
    func setdate(newDate : NSDate)
    {
        self.date = newDate
    }*/

}
