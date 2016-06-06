//
//  AddItemController.swift
//  final app
//
//  Created by DuyLinh on 5/23/16.
//  Copyright © 2016 DuyLinh. All rights reserved.
//

import UIKit
import Foundation
import CoreData
import CoreLocation

protocol addItemDelegate
{
    func addItem(listItem: ListItem)
}

private let reuseIdentifier = "PhotoCellIdentifier"

class AddItemController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate , CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager = CLLocationManager()
    var currentLocation: CLLocationCoordinate2D?
    var delegate: addItemDelegate?
    var currentList: List!
    var managedObjectContext: NSManagedObjectContext!
    var latitude: Double?
    var longitude: Double?
    
    var selectedImage: UIImage?
    var photoList: NSMutableArray?
    
    required init?(coder aDecoder: NSCoder){
        self.photoList = NSMutableArray()
        super.init(coder: aDecoder)
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var titleText: UITextField!
    
    @IBOutlet weak var descriptionText: UITextField!
    
    @IBOutlet weak var dateText: UIDatePicker!
    
    
    
    @IBAction func takePhoto(sender: AnyObject) {
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
            photoList!.addObject(selectedImage!)
            collectionView?.reloadData()
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photoList!.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> PhotoCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PhotoCell
        
        let img = photoList!.objectAtIndex(indexPath.row)
        
      
        cell.photoView!.image = img as? UIImage
        
        return cell

    }
    

   
 
    
    
        
    // current location 
    @IBAction func findMyLocation(sender: AnyObject) {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
      //  locationManager.distanceFilter = 10
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
    }
    
    func locationManager(manager: CLLocationManager,didUpdateLocations locations: [CLLocation]){
            let loc: CLLocation = locations.last!
            currentLocation = loc.coordinate
        self.latitude = currentLocation!.latitude
        self.longitude = currentLocation!.longitude
        displayBox(currentLocation!.latitude, longitude: currentLocation!.longitude)
        print(currentLocation!.latitude)
        print(currentLocation!.longitude)
        locationManager.stopUpdatingLocation()

    }
    
   
    
    
    
    
    
    
    
    @IBAction func saveButtonPressed(sender: AnyObject) {
        let title = titleText!.text
        let desc = descriptionText!.text
        let date = dateText!.date
        
        
        let listItem = NSEntityDescription.insertNewObjectForEntityForName("ListItem", inManagedObjectContext: self.managedObjectContext) as? ListItem
        
        listItem?.listItemName = title;
        listItem?.listItemDesc = desc;
        listItem?.listItemDate = date;
        listItem?.latitude = self.latitude;
        listItem?.longitude = self.longitude;
        
        
        
        // save Photo into core data
        
        for photo in photoList!
        {
        let savedPhoto = NSEntityDescription.insertNewObjectForEntityForName("Photo", inManagedObjectContext: self.managedObjectContext) as? Photo
        
        
       
            savedPhoto!.image = NSData(data: UIImageJPEGRepresentation(photo as! UIImage, 0.8)!)
           
            listItem?.addPhoto(savedPhoto!)
            
            
        
        }
        
        currentList.addListItem(listItem!)
        
    
        
        
        
       
        
        
        do{
            try self.managedObjectContext.save()
        }
        catch{
            print("error")
        }

        
        self.delegate!.addItem(listItem!)
        self.navigationController!.popViewControllerAnimated(true)
        
    }
    
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ViewPhotoSegue"
        {
            let controller: ViewPhotoController = segue.destinationViewController as! ViewPhotoController
            let indexPath = self.collectionView?.indexPathForCell(sender as! PhotoCell)
            controller.photoToView = (self.photoList?.objectAtIndex(indexPath!.row) as? UIImage)!
        }
    }

    
    func displayBox(latitude: Double?, longitude: Double?)
    {
        let alertController = UIAlertController(title: "Your location is ", message: "latitude:\(latitude!), longitude:\(longitude!)", preferredStyle:
            UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
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
