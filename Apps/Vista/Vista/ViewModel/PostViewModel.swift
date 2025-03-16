//
//  PhotoSelectViewModel.swift
//  Vista
//
//  Created by Lucas Takatori on 3/16/25.
//
import SwiftUI
import Photos
import CoreLocation

public class PostViewModel: NSObject, ObservableObject, PHPhotoLibraryChangeObserver {
    @Inject var imageRepository: ImageRepository
    @Inject var photoRepository: PhotoRepository
    @Published var caption: String = ""
    @Published var selectedPhoto: PhotoItem? = nil
    @Published var photos: [PhotoItem] = []
    
    public override init() {
        super.init()
        // Register self as a photo library change observer.
        PHPhotoLibrary.shared().register(self)
        // Use a Task to load photos asynchronously once the view model is created.
        Task {
            await loadPhotos()
        }
    }
    
    deinit {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }
    
    func loadPhotos() async {
        photos = await imageRepository.fetchAllPhotos()
    }
    
    public func photoLibraryDidChange(_ changeInstance: PHChange) {
        // Ensure UI updates happen on the main thread.
        Task { @MainActor in
            await loadPhotos()
        }
    }
    
    func selectPhoto(_ photo: PhotoItem) {
        selectedPhoto = photo
    }
    
    func uploadPhoto() async -> Bool {
        guard let photo = selectedPhoto else { return false }
        let success = try? await photoRepository.uploadPhoto(photo).get()
        return success ?? false
    }
}
