//
//  ContentView.swift
//  Vista
//
//  Created by Lucas Takatori on 3/11/25.
//

import SwiftUI
import MapKit

struct ContentView: View {
    var body: some View {
        TabView {
            // First Tab - Map View
            MapView()
                .tabItem {
                    Image(systemName: "map.fill") // Tab icon
                    Text("Map") // Tab label
                }

            // Second Tab - Example: a Text View
            Text("Other Tab")
                .tabItem {
                    Image(systemName: "star.fill") // Tab icon
                    Text("Other") // Tab label
                }
        }
    }
}
