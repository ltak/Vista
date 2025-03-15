//
//  PhotoUploadDescriptionView.swift
//  Vista
//
//  Created by Lucas Takatori on 3/15/25.
//

import SwiftUI

struct PhotoUploadDescriptionView: View {
    let photo: PhotoItem
    @State private var caption: String = ""
    @State private var hashtags: String = ""

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            // ✅ Display Selected Photo
            Image(uiImage: photo.image)
                .resizable()
                .scaledToFit()
                .frame(height: 250)
                .cornerRadius(10)
                .padding()

            // ✅ Caption Input Field
            TextField("Write a caption... Add hashtags (e.g. #travel #sunset)", text: $caption)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            // ✅ Post Button
            Button(action: postPhoto) {
                Text("Post")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
            }

            // ✅ Cancel Button
            Button(action: {
                dismiss()
            }) {
                Text("Cancel")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
            }

            Spacer()
        }
        .navigationTitle("New Post")
    }

    private func postPhoto() {
        print("Photo posted with caption: \(caption) and hashtags: \(hashtags)")
        dismiss()
    }
}
