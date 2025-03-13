//
//  ContentView.swift
//  Vista
//
//  Created by Lucas Takatori on 3/11/25.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    init() {
        // Set tab bar background color
        UITabBar.appearance().backgroundColor = UIColor.systemGray6
    }
    
    var body: some View {
        
        TabView {
            // First Tab - Map View
            MapView()
                .tabItem {
                    Image(systemName: "magnifyingglass") // Tab icon
                }

            // Second Tab - Example: a Text View
            PostView()
                .tabItem {
                    Image(systemName: "photo") // Tab icon
                }
            
            // Third Tab - Example: a Text View
            Text("Other Tab")
                .tabItem {
                    Image(systemName: "person.crop.circle") // Tab icon\
                }
            
        }
    }
}
