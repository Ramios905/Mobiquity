//
//  AddLocViewController.swift
//  Mobiquity Test
//
//  Created by Ram on 01/04/21.
//

import UIKit
import MapKit

class AddLocViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var addressLbl: UILabel!
    var currentCoordinate = CLLocationCoordinate2D()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Location"

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.hideTabBar()
        mapView.delegate = self
        currentCoordinate.longitude = LocationServices.shared.locationManager.location?.coordinate.longitude ?? 0
        currentCoordinate.latitude = LocationServices.shared.locationManager.location?.coordinate.latitude ?? 0
        mapView.showsUserLocation = true
        zoominguserLocation()
    }
    
    func zoominguserLocation() {
        let region = MKCoordinateRegion.init(center: currentCoordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
        mapView.setRegion(region, animated: true)
    }

    @IBAction func clickOnSave(_ sender: Any) {
        
        CoredataLayer().insertLocation(locObject: .init(locData: .init(locationName: addressLbl.text ?? "No name", fav: true, lat: Float(currentCoordinate.latitude), lon: Float(currentCoordinate.longitude),loc_id : "\(Date().timeIntervalSince1970)")))
        SystemAlert().basicNonActionAlert(withTitle: "", message: "Location added successfully", alert: .okAlert)
        self.tapBackToPreviousController(UIButton.self)
        
    }
    

}
extension AddLocViewController: MKMapViewDelegate,CLLocationManagerDelegate{
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        var newCoordinate = CLLocationCoordinate2D()
        newCoordinate.latitude = mapView.centerCoordinate.latitude
        newCoordinate.longitude = mapView.centerCoordinate.longitude
        currentCoordinate = newCoordinate
        
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(.init(latitude: currentCoordinate.latitude, longitude: currentCoordinate.longitude)) { [self] (placemarks, error) in
            guard let placemarks = placemarks, let placemark = placemarks.first else { return }
            if let city = placemark.locality,
                let zip = placemark.postalCode,
                let locationName = placemark.name{
                
                addressLbl.text = "\(locationName),\(city),\(zip)"
            }
                
                
                
           // self.locationInfoCallBack!(info)
        }
        
    }
    
}
