//
//  ImagePicker.swift
//  deSmet
//
//  Created by Jacob Shushanyan on 21.10.22.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var selectedImage: Image?
    @Binding var imageData: Data
    @Binding var showPhotoPicker: Bool
    
    
    func makeCoordinator() -> ImagePicker.Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {

        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = context.coordinator

        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {

    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
        
        var parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
            let uiImage = info[.editedImage] as! UIImage
            parent.selectedImage = Image(uiImage: uiImage)
            
            if let mediaData = uiImage.jpegData(compressionQuality: 0.5){
                parent.imageData = mediaData
                }
            parent.showPhotoPicker = false
            }
        }
    }

