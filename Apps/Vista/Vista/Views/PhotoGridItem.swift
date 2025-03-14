//
//  PhotoGridItem.swift
//  Vista
//
//  Created by Lucas Takatori on 3/13/25.
//

import SwiftUI

struct PhotoGridItem: View {
    let photo: PhotoItem
    let isSelected: Bool
    let onSelect: () -> Void

    var body: some View {
        Image(uiImage: photo.image)
            .resizable()
            .scaledToFill()
            .frame(width: 100, height: 100)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 3)
            )
            .onTapGesture {
                onSelect()
            }
    }
}
