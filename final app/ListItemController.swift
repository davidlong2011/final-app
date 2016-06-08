//
//  ListItemController.swift
//  final app
//
//  Created by DuyLinh on 5/5/16.
//  Copyright © 2016 DuyLinh. All rights reserved.
//

import UIKit
import CoreData
import Social

class ListItemController: UITableViewController, addItemDelegate {
    
   
   
    
    var listItemList = [ListItem]()
    var photoList = [Photo]()
    var currentList: List?
    var managedObjectContext: NSManagedObjectContext
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        self.listItemList = NSArray() as! [ListItem]
        self.photoList = NSArray() as! [Photo]
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.managedObjectContext = appDelegate.managedObjectContext
        super.init(coder: aDecoder)
    }

    @IBAction func facebookSharing(sender: AnyObject) {
        var line3 = ""
        for item in listItemList
        {
            line3 = line3 + "- " + (item.valueForKey("listItemName") as! String?)! + "\n"
        }

        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook){
            let facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            facebookSheet.setInitialText("This is my \((currentList!.category!.valueForKey("categoriesName") as! String?)!) list \n" +
                "for \((currentList!.valueForKey("listName") as! String?)!): \n" +
                line3)
            
            // "Date: \(formatADate(item.valueForKey("listItemDate") as! NSDate))"
            self.presentViewController(facebookSheet, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Accounts", message: "Please login to a Facebook account to share.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        
    }

  
    override func viewDidLoad() {
            super.viewDidLoad()
            
            listItemList = (currentList?.getListItem())!
       
 
            
        
    }
        
        
   
        
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listItemList.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "ListItemCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        // Configure the cell...
        let item = self.listItemList[indexPath.row]
        
        
        cell.textLabel!.text = item.valueForKey("listItemName") as! String
        cell.detailTextLabel!.text = "Date: \(formatADate(item.valueForKey("listItemDate") as! NSDate))"
        
        return cell
    }
    
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addItemSegue"
        {
            let controller: AddItemController = segue.destinationViewController as! AddItemController
            controller.delegate = self
            controller.currentList = self.currentList
            controller.managedObjectContext = self.managedObjectContext
        }
        else if segue.identifier == "ShowItemDetailSegue"
        {
            let selectedRow = self.tableView .indexPathForSelectedRow!.row
            let item = self.listItemList[selectedRow]
            photoList = self.listItemList[selectedRow].getPhotos()
           
            
        
            let controller: ViewItemController = segue.destinationViewController as! ViewItemController
            if((item.valueForKey("listItemName")) != nil)
            {
            controller.currentTitle = item.valueForKey("listItemName") as! String
            }
            if((item.valueForKey("listItemDesc")) != nil)
            {
            controller.currentDescription = item.valueForKey("listItemDesc") as! String
            }
            
            if((item.valueForKey("latitude")) != nil)
            {
            controller.currentLatitude = item.valueForKey("latitude") as! Double
            controller.currentLongitude = item.valueForKey("longitude") as! Double
            }
            
            controller.currentPhotos = photoList
            




            
            
           
            
        }
        
    }

  
    func addItem(listItem: ListItem) {
        self.listItemList.append(listItem)
        //self.saveList(listItem)
        self.tableView.reloadData()
    }
    
    func formatADate(date: NSDate) -> String
    {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        return dateFormatter.stringFromDate(date)
    }
    
    
    
    
   

   
    
 
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            let managedObjectContext = appDelegate.managedObjectContext
            managedObjectContext.deleteObject(listItemList[indexPath.row])
            listItemList.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            self.tableView.reloadData()
            
            
            
        }
    }
    
    
}
