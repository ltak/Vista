//
//  PhotoItem.swift
//  Vista
//
//  Created by Lucas Takatori on 3/13/25.
//

import UIKit
import Photos

struct PhotoItem: Equatable {
    let image: UIImage
    let asset: PHAsset
    
    static func == (lhs: PhotoItem, rhs: PhotoItem) -> Bool {
        return lhs.asset.localIdentifier == rhs.asset.localIdentifier
    }
}
