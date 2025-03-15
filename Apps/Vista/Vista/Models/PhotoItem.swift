//
//  PhotoItem.swift
//  Vista
//
//  Created by Lucas Takatori on 3/13/25.
//

import UIKit
import Photos

struct PhotoItem: Equatable, Hashable {
    let image: UIImage
    let asset: PHAsset
    
    static func == (lhs: PhotoItem, rhs: PhotoItem) -> Bool {
        return lhs.asset.localIdentifier == rhs.asset.localIdentifier
    }
    
    // Hashable - Use `localIdentifier` for unique identification
    func hash(into hasher: inout Hasher) {
        hasher.combine(asset.localIdentifier)
    }
}
