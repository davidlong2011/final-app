//
//  ProfileViewController.swift
//  final app
//
//  Created by DuyLinh on 6/7/16.
//  Copyright © 2016 DuyLinh. All rights reserved.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var selectedImage: UIImage?
    
   
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userNameLabel2: UILabel!

        
    @IBOutlet weak var profilePhoto: UIImageView!
    
    
    @IBAction func addPhoto(sender: AnyObject) {
        let imagePicker: UIImagePickerController = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        }
        else{
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        imagePicker.delegate = self
        navigationController!.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let dict = info as NSDictionary
        selectedImage = dict.objectForKey(UIImagePickerControllerOriginalImage) as? UIImage
        if selectedImage != nil{
        }
        self.dismissViewControllerAnimated(true, completion: nil)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "User")
        
        
        do{
            let results = try managedContext.executeFetchRequest(fetchRequest)
            
            
            let predicate = NSPredicate(format: "signedIn == %@", "1")
            
            let result = (results as NSArray).filteredArrayUsingPredicate(predicate)
            
            
            var objectUser : User = result.first as! User
            
            var savedImage: NSData = UIImageJPEGRepresentation(selectedImage!, 0.8)!
            
            objectUser.setValue(savedImage, forKey: "profileImage")
        }
            
        catch
        {
            print("error")
        }
        

        
       
        

        
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "User")
        
        
        do{
            let results = try managedContext.executeFetchRequest(fetchRequest)
            
            
            let predicate = NSPredicate(format: "signedIn == %@", "1")
            
            let result = (results as NSArray).filteredArrayUsingPredicate(predicate)
           
            
            var objectUser : User = result.first as! User
            
            userNameLabel.text = objectUser.userName
            
            userNameLabel2.text = "Hello " + objectUser.userName!.uppercaseString + " !"
            
        
            if (objectUser.profileImage != nil)
            {
           let image = UIImage(data: objectUser.profileImage!)!
           
            self.profilePhoto.image = image
            }
            else
            {
                self.profilePhoto.image = selectedImage
            }
     
                   }
            
        catch
        {
            print("error")
        }
  
    }
    
    
    @IBAction func changePassword(sender: AnyObject) {
        let alertController = UIAlertController(title: "New Password", message: "Type here", preferredStyle: .Alert)
        
     
        
        
        let confirmAction = UIAlertAction(title: "confirm", style: UIAlertActionStyle.Default, handler: ({
            (_) in
            if let field = alertController.textFields![0] as? UITextField
            {
                self.save(field.text!)
            }
            }
        ))
        
        
        
        let cancelAction = UIAlertAction(title:"Cancel", style: UIAlertActionStyle.Cancel,handler: nil)
        
        alertController.addTextFieldWithConfigurationHandler({
            (textField) in
            
            textField.placeholder = "New Password!!!"
            
        })
        
        
        
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        self.presentViewController(alertController, animated: true, completion: nil)
        
        
    }
    
    
    func save(itemToSave : String){
        
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "User")
        
        
        do{
            let results = try managedContext.executeFetchRequest(fetchRequest)
            
            let predicate = NSPredicate(format: "signedIn == %@", "1")
            
            let result = (results as NSArray).filteredArrayUsingPredicate(predicate)
            print (result)
            
            var objectUser : User = result.first as! User
            
            objectUser.setValue(itemToSave, forKey: "userPassword")
            
            
            
            var myAlert = UIAlertController(title: "Confirmation", message: "Your password is sucessfully changed, Thank you!", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default)
                {
                    action in
                    self.dismissViewControllerAnimated(true, completion: nil)
            }
            
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)

        }
            
        catch
        {
            print("error")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
