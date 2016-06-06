//
//  RegisterPageViewController.swift
//  final app
//
//  Created by DuyLinh on 5/11/16.
//  Copyright © 2016 DuyLinh. All rights reserved.
//

import UIKit
import CoreData

class RegisterPageViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var newPasswordTextField: UITextField!
    
    @IBOutlet weak var retypePasswordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func alreadyHaveAccButton(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func signupButton(sender: AnyObject) {
        let username = usernameTextField.text
        let newPassword = newPasswordTextField.text
        let retypePassword = retypePasswordTextField.text
        
        //Check empty field
        if((username!.isEmpty) || (newPassword!.isEmpty) || (retypePassword!.isEmpty))
        {
            //alert message
            displayMyAlertMessage("All fields are required")
            
        }
        
        if (newPassword != retypePassword)
        {
            displayMyAlertMessage("Password doesn't mactch")
        }
        
        //store Data
        
        var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var managedContext: NSManagedObjectContext = appDel.managedObjectContext
        var newUser = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: managedContext) as NSManagedObject
        newUser.setValue(username, forKey: "userName")
        newUser.setValue(newPassword, forKey: "userPassword")
        do{
            try managedContext.save()
        }
        catch{
            print("error")
        }
        
        
        
        
        
        
        
        var myAlert = UIAlertController(title: "Confirmation", message: "Registration is successful, Thank you!", preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default)
            {
                action in
                self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        myAlert.addAction(okAction)
        
        self.presentViewController(myAlert, animated: true, completion: nil)
        
        
    }
    
    func displayMyAlertMessage(message : String)
    {
        var myAlert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        
        myAlert.addAction(okAction)
        
        self.presentViewController(myAlert, animated: true, completion: nil)
    }
    
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
