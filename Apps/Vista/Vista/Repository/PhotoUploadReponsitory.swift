//
//  PhotoUploadReponsitory.swift
//  Vista
//
//  Created by Lucas Takatori on 3/15/25.
//

import UIKit

protocol PhotoRepository {
    func uploadPhoto(_ photo: PhotoItem) async -> Result<Bool, Error>
    func getPhotos() async -> Result<[PhotoItem], Error>
}

class MockPhotoRepository: PhotoRepository, ObservableObject {
    @Published private var uploadedPhotos: [PhotoItem] = []

    func uploadPhoto(_ photo: PhotoItem) async -> Result<Bool, Error> {
        try? await Task.sleep(nanoseconds: 1_000_000_000) // Simulates a 1-second delay

        Task { @MainActor in // Ensures UI updates happen on the main thread
            uploadedPhotos.append(photo) // Stores photo in memory
        }
        
        return Result.success(true) // Mimics successful upload
    }

    func getPhotos() async -> Result<[PhotoItem], Error> {
        try? await Task.sleep(nanoseconds: 1_000_000_000) // Simulates a 1-second delay
        return Result.success(uploadedPhotos)
    }
}
