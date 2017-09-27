//
//  MaptestViewController.swift
//  ChatTest
//
//  Created by MC-MG57035 on 6/1/2560 BE.
//  Copyright © 2560 Dol2oMo. All rights reserved.
//

import UIKit
import MapKit

protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}

class MaptestViewController: UIViewController,MKMapViewDelegate,UIGestureRecognizerDelegate,UISearchControllerDelegate {
    @IBOutlet weak var mymapview: MKMapView!
    
//    let mylocation = CLLocation()
    let mylocationmanager = CLLocationManager()
    var resultSearchController:UISearchController? = nil
    
    var selectedPin:MKPlacemark? = nil
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        let mylocation = CLLocation(latitude: 13.906705, longitude: 100.5189117)
//        
//        let locationradiue :CLLocationDistance = 1000
//        
//        mymapview.setRegion(MKCoordinateRegionMakeWithDistance(mylocation.coordinate, locationradiue, locationradiue), animated: true)
//        
//        let tgr = UITapGestureRecognizer(target: self, action: #selector(self.tapGestureHandler))
//        tgr.delegate = self
//        mymapview.addGestureRecognizer(tgr)
        
        mylocationmanager.delegate = self
        mylocationmanager.desiredAccuracy = kCLLocationAccuracyBest
        mylocationmanager.requestWhenInUseAuthorization()
        mylocationmanager.requestLocation()
        
        
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTableViewController") as! LocationSearchTableViewController
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        locationSearchTable.mapView = mymapview
        locationSearchTable.handleMapSearchDelegate = self
        
        

    }
    
    /*func tapGestureHandler(tgr: UITapGestureRecognizer)
    {
        let touchPoint = tgr.location(in: mymapview)
        let touchMapCoordinate = mymapview.convert(touchPoint, toCoordinateFrom: mymapview)
        print("tapGestureHandler: touchMapCoordinate = \(touchMapCoordinate.latitude),\(touchMapCoordinate.longitude)")
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: touchMapCoordinate.latitude, longitude: touchMapCoordinate.longitude)
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            // Address dictionary
            print(placeMark.addressDictionary)
            
            // Location name
            if let locationName = placeMark.addressDictionary!["Name"] as? NSString {
                print(locationName)
            }
            
            // Street address
            if let street = placeMark.addressDictionary!["Thoroughfare"] as? NSString {
                print(street)
            }
            
            // City
            if let city = placeMark.addressDictionary!["City"] as? NSString {
                print(city)
            }
            
            // Zip code
            if let zip = placeMark.addressDictionary!["ZIP"] as? NSString {
                print(zip)
            }
            
            // Country
            if let country = placeMark.addressDictionary!["Country"] as? NSString {
                print(country)
            }
            
        })
    }*/
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            
            return nil
        }
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        pinView?.pinTintColor = UIColor.orange
        pinView?.canShowCallout = true
        pinView?.isDraggable = true
        let smallSquare = CGSize(width: 30, height: 30)
        let button = UIButton(frame: CGRect(origin: .zero, size: smallSquare))
//        button.setBackgroundImage(UIImage.init(named: "cer"), for: .normal)
        button .setTitle("click", for: .normal)
        button .setTitleColor(UIColor .black, for: .normal)
        button.addTarget(self, action: #selector(MaptestViewController.getDirections), for: .touchUpInside)
        pinView?.leftCalloutAccessoryView = button
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationViewDragState, fromOldState oldState: MKAnnotationViewDragState) {
        if newState == MKAnnotationViewDragState.ending {
            let droppedAt = view.annotation?.coordinate
            print("djhsdjkhdsjkhdjkshsdjk\(String(describing: droppedAt))")
            
        }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        // Remove all annotations
        
        mymapview.removeAnnotations(mapView.annotations)
        
        // Add new annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = mapView.centerCoordinate
        
        
        print("\(mapView.centerCoordinate.latitude) , \(mapView.centerCoordinate.longitude)")
        
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            
//            print(placeMark.addressDictionary)
            
            annotation.title = "Mylocation"
            if let locationName = placeMark.addressDictionary!["Name"] as? NSString {
               annotation.subtitle =  locationName as String
            }
            else{
                annotation.subtitle = placeMark.addressDictionary!["City"] as? String
            }
            
            let addressDict = placeMark.addressDictionary
            
            let mkPlacemark = MKPlacemark(coordinate: placeMark.location!.coordinate, addressDictionary: addressDict as? [String : Any])
            
            self.selectedPin = mkPlacemark
        })
        
        mymapview.addAnnotation(annotation)
        
    }
    
    
    func getDirections(){
        if let selectedPin = selectedPin {
            let mapItem = MKMapItem(placemark: selectedPin)
            let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
            mapItem.openInMaps(launchOptions: launchOptions)
        }
    }
    
    

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension MaptestViewController :CLLocationManagerDelegate
{

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            mylocationmanager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.first
        
        if location != nil {
            let span = MKCoordinateSpanMake(0.01, 0.01)
            let region = MKCoordinateRegion(center: (location?.coordinate)!, span: span)
            mymapview.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: (error)")
    }
}

extension MaptestViewController: HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark){
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mymapview.removeAnnotations(mymapview.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        let city = placemark.locality
        let state = placemark.administrativeArea
        if city != nil,state != nil {
            annotation.subtitle = "\(String(describing: city)) \(String(describing: state))"
        }
        mymapview.addAnnotation(annotation)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mymapview.setRegion(region, animated: true)
    }
}



