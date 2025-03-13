//
//  MapView.swift
//  Vista
//
//  Created by Lucas Takatori on 3/12/25.
//

import SwiftUICore
import _MapKit_SwiftUI

struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), // San Francisco
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    var body: some View {
        Map(coordinateRegion: $region)
            .edgesIgnoringSafeArea(.all) // To make the map cover the full screen
    }
}
