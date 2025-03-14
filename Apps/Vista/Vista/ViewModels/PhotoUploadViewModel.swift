//
//  PhotoUploadViewModel.swift
//  Vista
//
//  Created by Lucas Takatori on 3/13/25.
//

import SwiftUI
import Swinject

class PhotoUploadViewModel: ObservableObject {
    @Inject var repository: ImageRepository
    @Published var photos: [PhotoItem] = []
    @Published var isAuthorized = false

    init() {
        Task {
            await checkAuthorization()
        }
    }

    // Check if the app has access to the photo library
    func checkAuthorization() async {
        isAuthorized = await repository.requestPhotoLibraryAccess()
        if isAuthorized {
            await loadPhotos()
        }
    }

    // Load all photos asynchronously
    func loadPhotos() async {
        let fetchedPhotos = await repository.fetchAllPhotos()
        DispatchQueue.main.async {
            self.photos = fetchedPhotos
        }
    }
}
