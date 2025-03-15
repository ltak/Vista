//
//  Photo.swift
//  Vista
//
//  Created by Lucas Takatori on 3/13/25.
//

import SwiftUI
import Photos

struct PhotoUploadView: View {
    private let tabTitle = "Photo Select"
    @StateObject private var viewModel = PhotoGalleryViewModel()
    @State private var navigateToPostScreen = false
    
    var body: some View {
        NavigationStack {
            // Display MapView for the selected photo
            VStack {
                
                // Map View
                ZStack {
                    MapView()
                        .frame(height: 250)
                        .cornerRadius(10)
                        .padding()
                    
                    // Show overlay if no photo is selected
                    if viewModel.selectedPhoto == nil {
                        Color.black.opacity(0.4) // Semi-transparent overlay
                            .frame(height: 250)
                            .cornerRadius(10)
                            .padding()
                            .overlay(
                                Text("Select a photo")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .bold()
                            )
                    }
                }
                // PhotoGrid
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                        ForEach(viewModel.photos, id: \.asset.localIdentifier) { photo in
                            PhotoGridItem(photo: photo,
                                          isSelected: viewModel.selectedPhoto == photo,
                                          onSelect: { viewModel.selectPhoto(photo) })
                        }
                    }
                    .padding()
                }
                
                // Continue Button to Post Screen
                NavigationLink(
                    value: viewModel.selectedPhoto
                ) {
                    Text("Continue")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(viewModel.selectedPhoto == nil ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                }
                .disabled(viewModel.selectedPhoto == nil)
            }
            .navigationTitle(tabTitle)
            .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text(tabTitle)
                            .font(.headline)
                            .bold()
                    }
                }
            .toolbarTitleDisplayMode(.inline)
            .navigationDestination(for: PhotoItem.self) { photo in
                PhotoUploadDescriptionView(photo: photo)
            }
        }
    }
}

