//
//  PhotoUploadReponsitory.swift
//  Vista
//
//  Created by Lucas Takatori on 3/15/25.
//

import UIKit

protocol PhotoUploadRepository {
    func uploadPhoto(_ photo: PhotoItem) async -> Result<Bool, Error>
    func getUploadedPhotos() async -> Result<[PhotoItem], Error>
}

class MockPhotoUploadRepository: PhotoUploadRepository, ObservableObject {
    @Published private var uploadedPhotos: [PhotoItem] = []

    func uploadPhoto(_ photo: PhotoItem) async -> Result<Bool, Error> {
        try? await Task.sleep(nanoseconds: 1_000_000_000) // Simulates a 1-second delay

        Task { @MainActor in // Ensures UI updates happen on the main thread
            uploadedPhotos.append(photo) // Stores photo in memory
        }
        
        return Result.success(true) // Mimics successful upload
    }

    func getUploadedPhotos() async -> Result<[PhotoItem], Error> {
        try? await Task.sleep(nanoseconds: 1_000_000_000) // Simulates a 1-second delay
        return Result.success(uploadedPhotos)
    }
}
