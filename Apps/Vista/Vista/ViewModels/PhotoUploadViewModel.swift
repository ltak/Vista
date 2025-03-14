//
//  PhotoUploadViewModel.swift
//  Vista
//
//  Created by Lucas Takatori on 3/13/25.
//
import SwiftUI
import Swinject


class PhotoGalleryViewModel: ObservableObject {
    @Inject private var repository: ImageRepository
    @Published var photos: [PhotoItem] = []
    @Published var selectedPhoto: PhotoItem?

    init() {
        Task { await loadPhotos() }
    }

    func loadPhotos() async {
        let fetchedPhotos = await repository.fetchAllPhotos()
        DispatchQueue.main.async {
            self.photos = fetchedPhotos
        }
    }

    func selectPhoto(_ photo: PhotoItem) {
        selectedPhoto = photo
    }
}
