//
//  VistaApp.swift
//  Vista
//
//  Created by Lucas Takatori on 3/11/25.
//

import SwiftUI
import Swinject

@main
struct VistaApp: App {
    init() {
        setupDependencies()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
