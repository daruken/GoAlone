//
//  MapView.swift
//  GoAlone
//
//  Created by HongYeol Jeon on 2020/09/06.
//  Copyright © 2020 HongYeol Jeon. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    var locationManager = CLLocationManager()
    
    func setupManager() {
      locationManager.desiredAccuracy = kCLLocationAccuracyBest
      locationManager.requestWhenInUseAuthorization()
      locationManager.requestAlwaysAuthorization()
    }
    
    func makeUIView(context: Context) -> MKMapView {
      setupManager()
      let mapView = MKMapView(frame: UIScreen.main.bounds)
      mapView.showsUserLocation = true
      mapView.userTrackingMode = .follow
      return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        view.showsUserLocation = true
        view.setUserTrackingMode(.follow, animated: true)
        
        let locationManager = CLLocationManager()

        let status = CLLocationManager.authorizationStatus()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()

        if status == .authorizedAlways || status == .authorizedWhenInUse {
            
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            let location: CLLocationCoordinate2D = locationManager.location!.coordinate
            let span = MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009)
            let region = MKCoordinateRegion(center: location, span: span)
            
            view.setRegion(region, animated: true)
         }
    }

}


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
