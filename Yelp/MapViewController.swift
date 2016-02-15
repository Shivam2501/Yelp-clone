//
//  MapViewController.swift
//  Yelp
//
//  Created by Shivam Bharuka on 2/15/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    
    var business: Business!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let centerlocation = CLLocation(latitude: 37.7833, longitude: -122.4167)
        goToLocation(centerlocation)
        
        let coordinate = CLLocationCoordinate2D(latitude: business.latitude!, longitude: business.longitude!)
        addAnnotationAtCoordinate(coordinate)
        // Do any additional setup after loading the view.
    }

    func goToLocation(location: CLLocation){
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegionMake(location.coordinate, span)
        mapView.setRegion(region, animated: false)
    }
    
    func addAnnotationAtCoordinate(coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "\(business.name!)"
        mapView.addAnnotation(annotation)
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
