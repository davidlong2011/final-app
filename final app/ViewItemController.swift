//
//  ViewItemController.swift
//  final app
//
//  Created by DuyLinh on 5/26/16.
//  Copyright © 2016 DuyLinh. All rights reserved.
//

import UIKit
import Foundation
import CoreData
import MapKit
import CoreLocation

private let reuseIdentifier = "PhotoCellIdentifier2"

class ViewItemController: UIViewController,UINavigationControllerDelegate, MKMapViewDelegate {
    
    var currentTitle : String?
    var currentDescription: String?
    var currentLatitude: Double?
    var currentLongitude: Double?
    var currentPhotos = [Photo]()
    var photoList: NSMutableArray?
    
    required init?(coder aDecoder: NSCoder){
        self.photoList = NSMutableArray()
        super.init(coder: aDecoder)
    }

    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    
    
    

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.mapView.showsUserLocation = true
        self.titleLabel.text = "Title : \(currentTitle!)"
        self.descriptionLabel.text = "Description : \(currentDescription!)"
        if(currentLatitude != nil)
        {
            
            let center = CLLocationCoordinate2D(latitude: currentLatitude!, longitude: currentLongitude!)
            
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta:0.05, longitudeDelta:0.05))
            
            self.mapView.setRegion(region, animated: true)
            
        self.locationLabel.text = "Latitude: \(currentLatitude!) , Longitude: \(currentLongitude!)"
        }
        
      if(currentPhotos.first != nil)
        {
        for photo in currentPhotos {
    
    
            let image : UIImage = UIImage(data: photo.image!)!
           
            photoList?.addObject(image)
        
        }

        }



    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photoList!.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> PhotoCell2 {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PhotoCell2
        
        let img = photoList!.objectAtIndex(indexPath.row)
        
       
        cell.PhotoView!.image = img as? UIImage
        
        return cell
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ViewPhotoSegue"
        {
            let controller: ViewPhotoController = segue.destinationViewController as! ViewPhotoController
            let indexPath = self.collectionView?.indexPathForCell(sender as! PhotoCell2)
    
            
            controller.photoToView = (self.photoList?.objectAtIndex(indexPath!.row) as? UIImage)!
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
