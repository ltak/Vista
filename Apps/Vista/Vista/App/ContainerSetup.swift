//
//  Container.swift
//  Vista
//
//  Created by Lucas Takatori on 3/13/25.
//
import Swinject

// Create a globally accessible Swinject container
let container = Container()

// Function to register all dependencies
func setupDependencies() {
    container.register(ImageRepository.self) { _ in PhotoLibraryRepository() }
}
