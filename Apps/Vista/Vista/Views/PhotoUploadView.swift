//
//  Photo.swift
//  Vista
//
//  Created by Lucas Takatori on 3/13/25.
//

import SwiftUI
import Photos

struct PhotoUploadView: View {
    @StateObject private var viewModel = PhotoGalleryViewModel()
    
    var body: some View {
        NavigationView {
            // Display MapView for the selected photo
            
            VStack {
                MapView()
                    .frame(height: 250)
                    .cornerRadius(10)
                    .padding()
                
                // Show overlay if no photo is selected
                //                                if viewModel.selectedPhoto == nil {
                //                                    Color.black.opacity(0.4) // Semi-transparent overlay
                //                                        .frame(height: 250)
                //                                        .cornerRadius(10)
                //                                        .padding()
                //                                        .overlay(
                //                                            Text("Select a photo to see its location")
                //                                                .font(.title2)
                //                                                .foregroundColor(.white)
                //                                                .bold()
                //                                        )
                //                                }
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
                .navigationTitle("Select a Photo")
            }
        }
    }
}

