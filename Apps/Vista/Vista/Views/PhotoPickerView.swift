//
//  PhotoPickerView.swift
//  Vista
//
//  Created by Lucas Takatori on 3/13/25.
//

import SwiftUICore
import _PhotosUI_SwiftUI
import SwiftUI

struct PhotoPickerView: View {
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var images: [UIImage] = []

    var body: some View {
        VStack {
            // Display selected images
            ScrollView(.horizontal) {
                HStack {
                    ForEach(images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(4)
                    }
                }
            }
            .frame(height: 120)

            // PhotosPicker for multi-selection
            PhotosPicker(
                selection: $selectedItems,
                matching: .images,
                photoLibrary: .shared()
            ) {
                Text("Select Photos")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .onChange(of: selectedItems) { oldItems, newItems in
            Task {
                await loadImages(from: newItems)
            }
        }
    }

    func loadImages(from items: [PhotosPickerItem]) async {
        images.removeAll() // Clear previous selection
        for item in items {
            if let data = try? await item.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: data) {
                images.append(uiImage)
            }
        }
    }
}
