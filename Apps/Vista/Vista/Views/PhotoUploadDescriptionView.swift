//
//  PhotoUploadDescriptionView.swift
//  Vista
//
//  Created by Lucas Takatori on 3/15/25.
//

import SwiftUI

struct PhotoUploadDescriptionView: View {
    
    let tabTitle = "Photo Upload"
    @State var photo: PhotoItem? = nil
    @State var caption: String = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            // Display Selected Photo
            Image(uiImage: photo?.image ?? UIImage())
                .resizable()
                .scaledToFit()
                .frame(height: 250)
                .cornerRadius(10)
                .padding()
            
            // Multi-line Caption Input Field
            TextEditor(text: $caption)
                .frame(height: 100) // ✅ Fixed height for multiple lines
                .padding(8)
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                .padding(.horizontal)
                .overlay(
                    VStack {
                        if caption.isEmpty {
                            Text("Write a caption... Add hashtags (e.g. #travel #sunset)")
                                .foregroundColor(.gray)
                                .padding()
                        }
                    },
                    alignment: .top
                )
            
            // Post Button
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
            Spacer()
        }
        .navigationTitle(tabTitle)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(tabTitle)
                    .font(.headline)
                    .bold()
            }
        }
        .toolbarTitleDisplayMode(.inline)
    }
    
    private func postPhoto() {
        print("Photo posted with caption: \(caption)")
        dismiss()
    }
}

