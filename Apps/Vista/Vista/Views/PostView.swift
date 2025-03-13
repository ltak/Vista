//
//  PostView.swift
//  Vista
//
//  Created by Lucas Takatori on 3/12/25.
//

import SwiftUI
import PhotosUI

struct PostView: View {
    @State private var selectedImage: UIImage? = nil
    @State private var selectedItem: PhotosPickerItem? = nil

    var body: some View {
        VStack {
            // Image preview
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                Text("No Image Selected")
                    .foregroundColor(.gray)
            }
            
            PhotoPickerView()

            // PhotosPicker Button
            PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
                Text("Select a Photo")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .onChange(of: selectedItem) { newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    selectedImage = uiImage
                }
            }
        }
    }
}
