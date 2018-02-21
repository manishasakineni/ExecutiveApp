//
//  MapTableViewCell.swift
//  Agent Payzan
//
//  Created by Nani Mac on 06/10/17.
//  Copyright © 2017 Naveen. All rights reserved.
//

import UIKit
import MapKit
import TextFieldEffects


class MapTableViewCell: UITableViewCell,MKMapViewDelegate,CLLocationManagerDelegate {
    
    
    @IBOutlet weak var lanLatTF: TextFieldEffects!
    
    @IBOutlet weak var userMapview: MKMapView!
  
    
    @IBOutlet weak var lanLatLbl: UILabel!
    
    
    @IBOutlet weak var nextClicked: UIButton!
    
    
    @IBOutlet weak var updateBtn: UIButton!
    
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    
    @IBOutlet weak var currentLocationBtn: UIButton!

    var address = NSDictionary()
    
   
    
    @IBOutlet weak var texfieldHeight: NSLayoutConstraint!
    
    @IBOutlet weak var mapHeight: NSLayoutConstraint!
    
    @IBOutlet weak var nextBtnHeight: NSLayoutConstraint!
    

    override func awakeFromNib() {
        super.awakeFromNib()
   
//      lanLatTF.borderStyle = .roundedRect
//        
//        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone) {
//            
//            texfieldHeight.constant = 30
//        }
//            
//        else{
//            
//            texfieldHeight.constant = 40
//        }
        
    }
    
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
//    {
//        let location = locations[0]
//        
//        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
//        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
//        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
//        self.userMapview.setRegion(region, animated: true)
//        
//        print(location.altitude)
//        print(location.speed)
//        
//        self.userMapview.showsUserLocation = true
//        
//        CLGeocoder().reverseGeocodeLocation(location) { (placemark, error) in
//            if error != nil
//            {
//                print ("THERE WAS AN ERROR")
//            }
//            else
//            {
//                if let place = placemark?[0]
//                {
//                    if let checker = place.subThoroughfare
//                    {
////                        self.label.text = "\(place.subThoroughfare!) \n \(place.thoroughfare!) \n \(place.country!)"
//                        
//                self.address = place.addressDictionary! as NSDictionary
//                    }
//                }
//            }
//        }
//    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    

    
    

    
    
    
    
    

//
//
//    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
//        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: { (placemarks, error) -> Void in
//            
//            // Place details
//            var placeMark: CLPlacemark!
//            placeMark = placemarks?[0]
//            
//            // Address dictionary
//            print(placeMark.addressDictionary, terminator: "")
//            
//            // Location name
//            if let locationName = placeMark.addressDictionary!["Name"] as? NSString {
//                print(locationName, terminator: "")
//            }
//            
//            // Street address
//            if let street = placeMark.addressDictionary!["Thoroughfare"] as? NSString {
//                print(street, terminator: "")
//            }
//            
//            // City
//            if let city = placeMark.addressDictionary!["City"] as? NSString {
//                print(city, terminator: "")
//            }
//            
//            // Zip code
//            if let zip = placeMark.addressDictionary!["ZIP"] as? NSString {
//                print(zip, terminator: "")
//            }
//            
//            // Country
//            if let country = placeMark.addressDictionary!["Country"] as? NSString {
//                print(country, terminator: "")
//            }
//            
//        })
//        
//        let location = locations[0]
        // Create a coordinate based on users location latitude and longitude
    
//    }
//
//    //    func displayLocationInfo(placemark: CLPlacemark) {
//    //        if placemark != nil {
//    //            //stop updating location to save battery life
//    //            .stopUpdatingLocation()
//    //            print(placemark.locality ? placemark.locality : "")
//    //            print(placemark.postalCode ? placemark.postalCode : "")
//    //            print(placemark.administrativeArea ? placemark.administrativeArea : "")
//    //            print(placemark.country ? placemark.country : "")
//    //        }
//    //    }
//    //
    
//    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
//        print("Error while updating location " + error.localizedDescription)
//    }
//    
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        
//        let location = locations[0]
//        
//        let latitude = location.coordinate.latitude
//        
//        let longitude = location.coordinate.longitude
//        
//        print(latitude,longitude)
//        
   }

