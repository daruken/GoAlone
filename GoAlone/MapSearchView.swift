//
//  MapSearchView.swift
//  GoAlone
//
//  Created by HongYeol Jeon on 2020/09/11.
//  Copyright © 2020 HongYeol Jeon. All rights reserved.
//

import SwiftUI
import MapKit

struct MapSearchView: UIViewControllerRepresentable {
    class Coordinator: NSObject, MapViewDelegate {
        func saveLocation(placemark: MKPlacemark) {
            print("add placemark" )
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<MapSearchView>) -> MapViewController {
        let mapController = MapViewController()
        return mapController
    }

    func updateUIViewController(_ uiViewController: MapViewController,
                                context: UIViewControllerRepresentableContext<MapSearchView>) {
        uiViewController.delegate = context.coordinator
    }
}

struct MapSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MapSearchView()
    }
}
