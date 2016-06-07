//
//  CategoriesController.swift
//  final app
//
//  Created by DuyLinh on 5/4/16.
//  Copyright © 2016 DuyLinh. All rights reserved.
//

import UIKit
import CoreData

class CategoriesController: UITableViewController, setUserIsLoggedInDelegate {
    
    var listCategories = [Category]()
    //var currentCategory: Category?
    var userIsLoggedIn : Bool? = false
     var managedObjectContext: NSManagedObjectContext
    
    
    required init?(coder aDecoder: NSCoder) {
        self.listCategories = NSArray() as! [Category]
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.managedObjectContext = appDelegate.managedObjectContext
        super.init(coder: aDecoder)
    }
    
    override func viewDidAppear(animated: Bool) {
        
       if(userIsLoggedIn == false)
       {
        self.performSegueWithIdentifier("loginView", sender: self)
       }
    }
    
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest = NSFetchRequest()
        let entityDescription = NSEntityDescription.entityForName("Category", inManagedObjectContext: self.managedObjectContext)
        fetchRequest.entity = entityDescription
        
        do{
            let results = try self.managedObjectContext.executeFetchRequest(fetchRequest)
            listCategories = results as! [Category]
            if self.listCategories.count == 0
            {
                self.saveCategories("Shopping")
                self.saveCategories("Work-out List")
                self.saveCategories("Todo-list")
            }
        
            
        }
        catch{
            print("error")
        }


    }
    
    @IBAction func addCategories(sender: AnyObject) {
        let alertController = UIAlertController(title: "New Categories", message: "Type here", preferredStyle: .Alert)
        
        print(listCategories.count)
        
        
        let confirmAction = UIAlertAction(title: "confirm", style: UIAlertActionStyle.Default, handler: ({
            (_) in
            if let field = alertController.textFields![0] as? UITextField
            {
                self.saveCategories(field.text!)
                self.tableView.reloadData()
            }
            }
        ))
        
        
        
        let cancelAction = UIAlertAction(title:"Cancel", style: UIAlertActionStyle.Cancel,handler: nil)
        
        alertController.addTextFieldWithConfigurationHandler({
            (textField) in
            
            textField.placeholder = "New Categories!!!"
            
        })
        
        
        
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        self.presentViewController(alertController, animated: true, completion: nil)

        
    }
   
    
    func saveCategories(itemToSave : String){
        
        let categoriesItem = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: self.managedObjectContext) as? Category
        
        
        categoriesItem!.setValue(itemToSave, forKey: "categoriesName")
        
        do{
            try self.managedObjectContext.save()
            listCategories.append(categoriesItem!)
        }
        catch{
            print("error")
        }
    }
    
    
    
    @IBAction func logOutButton(sender: AnyObject) {
        
        userIsLoggedIn = false
        print(userIsLoggedIn)
        self.performSegueWithIdentifier("loginView", sender: self)
        
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "User")
        
        
        do{
            let results = try managedContext.executeFetchRequest(fetchRequest)
            print(results)
            print("nono")
            
            let predicate = NSPredicate(format: "signedIn == %@", "1")
            
            let result = (results as NSArray).filteredArrayUsingPredicate(predicate)
            print(result)
            print("haha")
            
            if (results.count > 0)
            {
                if(result.first != nil)
                {
                   for eachresult in result
                   {
                    var objectUser : User = eachresult as! User
                    objectUser.setValue("0", forKey: "signedIn")
                    print(result)
                    print("yes")
                    }
                    
                }
                
            }
        }
            
            catch
            {
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
        return listCategories.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
            let cellIdentifier = "CategoriesCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
            
            // Configure the cell...
            let item = self.listCategories[indexPath.row]
            
            
            cell.textLabel!.text = item.valueForKey("categoriesName") as! String
        
            
            
            return cell
    }
    
    override func viewWillAppear(animated: Bool) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Category")
        
        do{
            let results = try managedContext.executeFetchRequest(fetchRequest)
            listCategories = results as! [Category]
        }
        catch{
            print("error")
        }
        self.tableView.reloadData()

    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            let managedObjectContext = appDelegate.managedObjectContext
            managedObjectContext.deleteObject(listCategories[indexPath.row])
            listCategories.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            self.tableView.reloadData()
           
            
            
        }
    }
    
  
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("ShowListSegue", sender: indexPath);
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ShowListSegue"
        {
            let destVC = segue.destinationViewController as! ListController
            
            let selectedRow = (sender as! NSIndexPath).row
            destVC.currentCategory = self.listCategories[selectedRow]
          //  destVC.lists = self.listCategories[selectedRow].getList()
        
        }
        
        if segue.identifier == "loginView"
        {
            let destVC = segue.destinationViewController as! LoginViewController
            
            destVC.delegate = self
        }
        
    }
    
    
    func set(userIsLoggin: Bool) {
        self.userIsLoggedIn = userIsLoggin
        print(userIsLoggedIn)
    }
   
    
    
   }
