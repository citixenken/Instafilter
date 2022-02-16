//
//  ImagePicker.swift
//  Instafilter
//
//  Created by Ken Muyesu on 16/02/2022.
//

import Foundation
import PhotosUI
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        return picker 
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        //not in use
    }
}
