//
//  Photo.swift
//  Vista
//
//  Created by Lucas Takatori on 3/13/25.
//

import SwiftUI

struct PhotoUploadView: View {
    let tabTitle = "Photo Select"
    @Inject private var repository: ImageRepository
    @State var photos: [PhotoItem]? = nil
    @State var selectedPhoto: PhotoItem? = nil
    
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
                    if selectedPhoto == nil {
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
                        ForEach(photos ?? [], id: \.asset.localIdentifier) { photo in
                            PhotoGridItem(photo: photo,
                                          isSelected: selectedPhoto == photo,
                                          onSelect: { selectedPhoto = photo })
                        }
                    }
                }
                
                // Continue Button to Post Screen
                NavigationLink(
                    value: selectedPhoto
                ) {
                    Text("Continue")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selectedPhoto == nil ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                }
                .disabled(selectedPhoto == nil)
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
        }.task {
            photos = await repository.fetchAllPhotos()
        }
    }
}

