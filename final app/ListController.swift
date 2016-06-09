//
//  ListController.swift
//  final app
//
//  Created by DuyLinh on 5/5/16.
//  Copyright © 2016 DuyLinh. All rights reserved.
//

import UIKit
import CoreData

class ListController: UITableViewController {

    
    var lists = [List]()
    var currentCategory: Category?
    var managedObjectContext: NSManagedObjectContext

    
    required init?(coder aDecoder: NSCoder) {
        self.lists = NSArray() as! [List]
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.managedObjectContext = appDelegate.managedObjectContext
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lists = (currentCategory?.getList())!
        
        

        
        
        
        
    }
    
    
    @IBAction func addList(sender: AnyObject) {
        let alertController = UIAlertController(title: "New List", message: "Type here", preferredStyle: .Alert)
        
        print(lists.count)
        
        
        let confirmAction = UIAlertAction(title: "confirm", style: UIAlertActionStyle.Default, handler: ({
            (_) in
            if let field = alertController.textFields![0] as? UITextField
            {
                self.saveList(field.text!)
                self.tableView.reloadData()
            }
            }
        ))
        
        
        
        let cancelAction = UIAlertAction(title:"Cancel", style: UIAlertActionStyle.Cancel,handler: nil)
        
        alertController.addTextFieldWithConfigurationHandler({
            (textField) in
            
            textField.placeholder = "New Lists!!!"
            
        })
        
        
        
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        self.presentViewController(alertController, animated: true, completion: nil)
        
        
    }
    
    
    func saveList(itemToSave : String){
        
        let listsItem = NSEntityDescription.insertNewObjectForEntityForName("List", inManagedObjectContext: self.managedObjectContext) as? List
        
        currentCategory?.addList(listsItem!)
        listsItem!.setValue(itemToSave, forKey: "listName")
        //categoriesItem.category = self.currentCategory
        
        do{
            try self.managedObjectContext.save()
            lists.append(listsItem!)
        }
        catch{
            print("error")
        }
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
        return lists.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "ListCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        // Configure the cell...
        let item = self.lists[indexPath.row]
        
     
        
        //cell.textLabel!.text =
        cell.textLabel!.text = item.valueForKey("listName") as! String
        //                 listItemList = (currentList?.getListItem())!
        cell.detailTextLabel!.text = String(item.getListItem().count)

        
        
        
        
        return cell
    }
    
      
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            let managedObjectContext = appDelegate.managedObjectContext
            managedObjectContext.deleteObject(lists[indexPath.row])
            lists.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            self.tableView.reloadData()
            
            
            
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("listItemSegue", sender: indexPath);
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "listItemSegue"
        {
            let destVC = segue.destinationViewController as! ListItemController
           
            let selectedRow = (sender as! NSIndexPath).row
            destVC.currentList = self.lists[selectedRow]
            //destVC.lists = self.listCategories[selectedRow].getList()
            
        }


}
}
