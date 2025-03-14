//
//  Photo.swift
//  Vista
//
//  Created by Lucas Takatori on 3/13/25.
//

import SwiftUI
import Photos

struct PhotoUploadView: View {
    @State private var images: [(UIImage, PHAsset)] = [] // Store fetched images
    @State private var selectedAsset: PHAsset? = nil // Track the selected photo
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
                    ForEach(images, id: \.1.localIdentifier) { (image, asset) in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .overlay(Rectangle().stroke(selectedAsset == asset ? Color.blue : Color.clear, lineWidth: 2)
                            )
                            .onTapGesture {
                                selectedAsset = asset
                            }
                    }
                }
                .padding()
            }
            .navigationTitle("Select a Photo")
            .onAppear {
                requestPhotoLibraryAccess()
            }
        }
    }

    // Request permission to access photos
    func requestPhotoLibraryAccess() {
        PHPhotoLibrary.requestAuthorization { status in
            if status == .authorized || status == .limited {
                fetchAllPhotos()
            }
        }
    }

    // Fetch all photos and store them in `images`
    func fetchAllPhotos() {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let fetchResult: PHFetchResult<PHAsset> = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        
        let imageManager = PHCachingImageManager()
        let targetSize = CGSize(width: 200, height: 200) // Thumbnail size

        fetchResult.enumerateObjects { (asset, _, _) in
            let requestOptions = PHImageRequestOptions()
            requestOptions.isSynchronous = true
            
            imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: requestOptions) { image, _ in
                if let image = image {
                    DispatchQueue.main.async {
                        images.append((image, asset))
                    }
                }
            }
        }
    }
}
