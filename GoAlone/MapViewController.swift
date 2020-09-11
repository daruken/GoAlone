//
//  SearchBar.swift
//  GoAlone
//
//  Created by HongYeol Jeon on 2020/09/10.
//  Copyright © 2020 HongYeol Jeon. All rights reserved.
//

import UIKit
import MapKit

protocol MapViewDelegate{
    func saveLocation(placemark: MKPlacemark)
}

class MapViewController: UIViewController {
 
    var delegate:MapViewDelegate!
    var mapView: MKMapView!
 
     // MARK: - Search
     fileprivate var searchBar: UISearchBar!
     fileprivate var localSearchRequest: MKLocalSearch.Request!
     fileprivate var localSearch: MKLocalSearch!
     fileprivate var localSearchResponse: MKLocalSearch.Response!
     
     // MARK: - Map variables
     
     fileprivate var annotation: MKAnnotation!
     fileprivate var isCurrentLocation: Bool = false
     
     var selectedPin: MKPlacemark?
    // MARK: - UIViewController's methods
 
    override func viewDidLoad() {
        super.viewDidLoad()
  
        mapView = MKMapView()
      
        let leftMargin:CGFloat = 10
        let topMargin:CGFloat = 60
        let mapWidth:CGFloat = view.frame.size.width-20
        let mapHeight:CGFloat = view.frame.size.height - 100
            
        mapView.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        self.view.addSubview(mapView)
      
        searchBar = UISearchBar(frame: CGRect(x: 10, y: 0, width: mapWidth, height: 60))
        searchBar.delegate = self
        self.view.addSubview(searchBar)
      
        mapView.delegate = self
        mapView.mapType = .hybrid
    }
}
 
extension MapViewController:MKMapViewDelegate{
 
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        guard !(annotation is MKUserLocation) else { return nil }
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        }

        pinView?.pinTintColor = UIColor.orange
        pinView?.canShowCallout = true
        let smallSquare = CGSize(width: 30, height: 30)
        let button = UIButton(frame: CGRect(origin: CGPoint.zero, size: smallSquare))
  
        button.setBackgroundImage(UIImage(systemName: "plus.square"), for: .normal)
        button.addTarget(self, action: #selector(savedPin), for: .touchUpInside)
  
        pinView?.leftCalloutAccessoryView = button
  
        return pinView
        
    }
 
    @objc func savedPin(){
        guard let delegate = delegate, let placemark = selectedPin else { return}
        delegate.saveLocation(placemark: placemark)
    }
}

extension MapViewController:UISearchBarDelegate{
    // MARK: - UISearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if self.mapView.annotations.count != 0 {
            annotation = self.mapView.annotations[0]
            self.mapView.removeAnnotation(annotation)
        }
  
        localSearchRequest = MKLocalSearch.Request()
        localSearchRequest.naturalLanguageQuery = searchBar.text
        localSearch = MKLocalSearch(request: localSearchRequest)
        localSearch.start { (localSearchResponse, error) -> Void in
            if localSearchResponse == nil {
                return self.showAlert()
            }
   
            guard let mapItem = localSearchResponse?.mapItems.first else {
                return self.showAlert()
            }
   
            let placemark = mapItem.placemark
   
            self.addPin( placemark: placemark)
            self.selectedPin = placemark
        }
    }
 
    func showAlert(){
        let alert = UIAlertController(title: nil, message:"Place not found", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try again", style: .default) { _ in })
        self.present(alert, animated: true){}
    }
 
    func addPin(placemark: MKPlacemark){
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
  
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
  
        addAnnotation(annotation: annotation)
    }
 
    func addAnnotation( annotation:MKPointAnnotation ){
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: annotation.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
}
