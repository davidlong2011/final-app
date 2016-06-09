//
//  LoginViewController.swift
//  final app
//
//  Created by DuyLinh on 5/11/16.
//  Copyright © 2016 DuyLinh. All rights reserved.
//

import UIKit
import CoreData


protocol setUserIsLoggedInDelegate{
    func set(userIsLoggin: Bool)
}

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    var delegate: setUserIsLoggedInDelegate?
    
    var userIsLoggedIn : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "User")
        
        
        do{
            let results = try managedContext.executeFetchRequest(fetchRequest)
            
            
            let predicate = NSPredicate(format: "signedIn == %@", "1")
            
            let result = (results as NSArray).filteredArrayUsingPredicate(predicate)
           // print(result)
           // print("haha")
            
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
        


        
        
        
        
        
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonPressed(sender: AnyObject) {
        let username = usernameTextField.text
        let password = passwordTextField.text
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "User")
      
        
        
        do{
            let results = try managedContext.executeFetchRequest(fetchRequest)
            let predicate = NSPredicate(format: "userName == %@", username!)

            //let result = results.filteredArrayUsingPredicate(predicate)
            let result = (results as NSArray).filteredArrayUsingPredicate(predicate)
            
            if (results.count > 0)
            {
                if(result.first != nil)
                {
                    var objectUser : User = result.first as! User
                   
                    if (objectUser.userName! == username && objectUser.userPassword! == password)
                    
                        {
                            self.dismissViewControllerAnimated(true, completion: nil)
                            userIsLoggedIn = true
                            self.delegate!.set(userIsLoggedIn)
                           // print(results)
                           // print(objectUser.userName)
                           // print(objectUser.userPassword)
                           // print(objectUser.signedIn)
                            result.first?.setValue("1", forKey: "signedIn")
                          //  print(objectUser.signedIn)
                        }
                    else{
                        displayMyAlertMessage("Wrong Username/Password")
                        }
                }
                else
                {
                    displayMyAlertMessage("Wrong Username/Password")
                    
                }
            }
            
    
        }
        catch{
            print("error")
        }
        
        
        
        

        
        
    }
    func displayMyAlertMessage(message : String)
    {
        var myAlert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        
        myAlert.addAction(okAction)
        
        self.presentViewController(myAlert, animated: true, completion: nil)
    }
    
    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "loginView"
        {
            let destVC = segue.destinationViewController as! CategoriesController
            
            destVC.userIsLoggedIn = self.userIsLoggedIn
            
        }
*/
   


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


