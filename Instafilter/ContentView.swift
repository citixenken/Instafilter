//
//  ContentView.swift
//  Instafilter
//
//  Created by Ken Muyesu on 15/02/2022.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var showingImagePicker = false
    
    @State private var inputImage: UIImage?
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            
            Button("Select Image") {
                showingImagePicker = true
            }
            
            Button("Save Image") {
                guard let inputImage = inputImage else {
                    return
                }
                let imageSaver = ImageSaver()
                imageSaver.writeToPhotoAlbum(image: inputImage)
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
        .onChange(of: inputImage) { _ in loadImage() }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else {
            return
        }
        image = Image(uiImage: inputImage)
        
        //immediately saves image that got loaded; creating a duplicate
        
        //UIImageWriteToSavedPhotosAlbum(inputImage, nil, nil, nil)

    }
}

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
}

//struct ContentView: View {
//    //    @State private var blurAmount = 0.0
//
//    //    {
//    //        didSet {
//    //            print("New value is \(blurAmount)")
//    //        }
//    //    }
//
//    //    @State private var showingConfirmation = false
//    //    @State private var backgroundColor = Color.white
//    @State private var image: Image?
//
//    var body: some View {
//        VStack {
//            image?
//                .resizable()
//                .scaledToFit()
//        }
//        .onAppear(perform: loadImage)
//
//        //        Text("Hello, world!")
//        //            .frame(width: 300, height: 300)
//        //            .background(backgroundColor)
//        //            .onTapGesture {
//        //                showingConfirmation = true
//        //            }
//        //
//        //            .confirmationDialog("Change background", isPresented: $showingConfirmation) {
//        //                Button("Red") { backgroundColor = .red }
//        //                Button("Green") { backgroundColor = .green }
//        //                Button("Blue") { backgroundColor = .blue }
//        //                Button("Cancel", role: .cancel) { }
//        //            } message: {
//        //                Text("Select a new color")
//        //            }
//        ////        VStack {
//        ////            Text("Hello, world!")
//        ////                .blur(radius: blurAmount)
//        ////
//        ////
//        ////            Slider(value: $blurAmount, in: 0...10)
//        ////                .onChange(of: blurAmount) { newValue in
//        ////                    print("New value is \(newValue)")
//        ////                }
//        ////
//        ////                        Button("Random Blur") {
//        ////                            blurAmount = Double.random(in: 1...10)
//        ////        }
//        //  }
//    }
//    func loadImage() {
//        //image = Image("ck")
//        guard let inputImage = UIImage(named: "ck") else { return }
//        let beginImage = CIImage(image: inputImage)
//
//        let context = CIContext()
//        //let currentFilter = CIFilter.sepiaTone()
//        let currentFilter = CIFilter.pixellate()
//        //let currentFilter = CIFilter.crystallize()
//        //let currentFilter = CIFilter.twirlDistortion()
//        currentFilter.inputImage = beginImage
//
//        //currentFilter.intensity = 0.7
//        //currentFilter.scale = 20
//        //currentFilter.radius = 20
//        currentFilter.center = CGPoint(x: inputImage.size.width / 2, y: inputImage.size.height / 2)
//
//        let amount = 1.0
//        let inputKeys = currentFilter.inputKeys
//        if inputKeys.contains(kCIInputIntensityKey) {
//            currentFilter.setValue(amount, forKey: kCIInputIntensityKey)
//        }
//        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(amount * 200, forKey: kCIInputRadiusKey) }
//        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(amount * 10, forKey: kCIInputScaleKey) }
//
//
//        //get a CIImage from our filter or exit if that fails
//        guard let outputImage = currentFilter.outputImage else { return }
//
//        //attempt to get a CGImage from a CIImage
//        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
//
//            //convert back to a UIImage
//            let uiImage = UIImage(cgImage: cgimg)
//
//            //and convert that to a SwiftUI image
//            image = Image(uiImage: uiImage)
//        }
//    }
//}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
