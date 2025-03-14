//
//  MapView.swift
//  Vista
//
//  Created by Lucas Takatori on 3/12/25.
//
import SwiftUI
import MapKit

struct MapView: View {
    var coordinate: CLLocationCoordinate2D? = nil

    @State private var region: MKCoordinateRegion

    init(coordinate: CLLocationCoordinate2D? = nil) {
        _region = State(initialValue: MKCoordinateRegion(
            center: coordinate ?? CLLocationCoordinate2D(),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        ))
    }

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: [MapPinItem(coordinate: coordinate ?? CLLocationCoordinate2D(latitude: 0,longitude: 0))]) { pin in
            MapMarker(coordinate: pin.coordinate, tint: .red)
        }
    }
}

struct MapPinItem: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}
