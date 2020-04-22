//
//  ImagePicker.swift
//  BabyMedSwiftUI
//
//  Created by Oleg Ten on 4/21/20.
//  Copyright © 2020 Oleg Ten. All rights reserved.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIImagePickerController
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
    @Binding var imageURL: NSURL?
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
        let parent: ImagePicker
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage{
                parent.image = uiImage
            
            }
            if let uiImageURL = info[.imageURL] as? NSURL{
                parent.imageURL = uiImageURL
            
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeCoordinator() -> ImagePicker.Coordinator {
           Coordinator(self)
       }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        print(" ")
    }
    
}
