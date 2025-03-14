//
//  ImageRepository.swift
//  Vista
//
//  Created by Lucas Takatori on 3/13/25.
//

import Foundation
import Photos
import UIKit

protocol ImageRepository {
    func requestPhotoLibraryAccess() async -> Bool
    func fetchAllPhotos() async -> [PhotoItem]
    func fetchImage(for asset: PHAsset) async -> UIImage?
}

class PhotoLibraryRepository: ImageRepository {
    private let imageManager = PHCachingImageManager()
    private let cache = NSCache<NSString, UIImage>()

    // Request Photo Library Access (Async)
    func requestPhotoLibraryAccess() async -> Bool {
        return await withCheckedContinuation { continuation in
            PHPhotoLibrary.requestAuthorization { status in
                continuation.resume(returning: status == .authorized || status == .limited)
            }
        }
    }

    // Fetch All Photos (Async)
    func fetchAllPhotos() async -> [PhotoItem] {
        var photoItems: [PhotoItem] = []
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let fetchResult: PHFetchResult<PHAsset> = PHAsset.fetchAssets(with: .image, options: fetchOptions)

        for index in 0..<fetchResult.count {
            let asset = fetchResult.object(at: index)
            if let image = await fetchImage(for: asset) {
                photoItems.append(PhotoItem(image: image, asset: asset))
            }
        }
        
        return photoItems
    }

    // Fetch Image for a Given Asset (Async + Caching)
    func fetchImage(for asset: PHAsset) async -> UIImage? {
        let assetID = asset.localIdentifier as NSString

        // Check cache first
        if let cachedImage = cache.object(forKey: assetID) {
            return cachedImage
        }

        return await withCheckedContinuation { continuation in
            let targetSize = CGSize(width: 200, height: 200)
            let requestOptions = PHImageRequestOptions()
            requestOptions.isSynchronous = false
            
            imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: requestOptions) { image, _ in
                if let image = image {
                    self.cache.setObject(image, forKey: assetID) // Store in cache
                }
                continuation.resume(returning: image)
            }
        }
    }
}
