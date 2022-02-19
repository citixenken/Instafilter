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
    @State private var filterIntensity = 0.5
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    @State private var showingFilterSheet = false
    @State private var processedImage: UIImage?
    
    
    //    @State private var image: Image?
    //    @State private var showingImagePicker = false
    //
    //    @State private var inputImage: UIImage?
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(.secondary)
                Text("Tap gray area to select a picture")
                    .foregroundColor(.white)
                    .font(.headline)
                
                image?
                    .resizable()
                    .scaledToFit()
            }
            .onTapGesture {
                showingImagePicker = true
            }
            
            HStack {
                Text("Intensity")
                Slider(value: $filterIntensity)
                    .onChange(of: filterIntensity) { _ in
                        applyProcessing()
                    }
            }
            .padding()
            
            HStack {
                Button("Change Filter") {
                    showingFilterSheet = true
                }
                
                Spacer()
                
                Button("Save", action: save)
                //save the picture
            }
            .padding()
        }
        .padding([.vertical, .bottom])
        .navigationTitle("Instafilter")
        
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
        
        .confirmationDialog("Select a filter", isPresented: $showingFilterSheet) {
            Button("Crystallize") {
                setFilter(CIFilter.crystallize())
            }
            Button("Edges") {
                setFilter(CIFilter.edges())
            }
            Button("Gaussian Blur") {
                setFilter(CIFilter.gaussianBlur())
            }
            Button("Pixellate") {
                setFilter(CIFilter.pixellate())
            }
            Button("Sepia Tone") {
                setFilter(CIFilter.sepiaTone())
            }
            Button("Unsharp Mask") {
                setFilter(CIFilter.unsharpMask())
            }
            Button("Vignette") {
                setFilter(CIFilter.vignette())
            }
            Button("Twirl Distortion") {
                setFilter(CIFilter.twirlDistortion())
            }
            Button("Circular Wrap") {
                setFilter(CIFilter.circularWrap())
            }
            Button("Cancel", role: .cancel) {}
        }
        
        .onChange(of: inputImage) {
            _ in loadImage()
        }
        
        
        
        //        VStack {
        //            image?
        //                .resizable()
        //                .scaledToFit()
        //
        //            Button("Select Image") {
        //                showingImagePicker = true
        //            }
        //
        //            Button("Save Image") {
        //                guard let inputImage = inputImage else {
        //                    return
        //                }
        //                let imageSaver = ImageSaver()
        //                imageSaver.writeToPhotoAlbum(image: inputImage)
        //            }
        //        }
        //        .sheet(isPresented: $showingImagePicker) {
        //            ImagePicker(image: $inputImage)
        //        }
        //        .onChange(of: inputImage) { _ in loadImage() }
    }
    
    func save() {
        guard let processedImage = processedImage else {
            return
        }
        let imageSaver = ImageSaver()
        
        imageSaver.successHandler = {
            print("Success!")
        }
        
        imageSaver.errorHandler = {
            print("Oops: \($0.localizedDescription)")
        }
        
        imageSaver.writeToPhotoAlbum(image: processedImage)
    }
    
    func loadImage() {
        guard let inputImage = inputImage else {
            return
        }
//        image = Image(uiImage: inputImage)
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing() {
        //currentFilter.intensity = Float(filterIntensity)
        //currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)}
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey)}
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)}
        
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
    
    //    func loadImage() {
    //        guard let inputImage = inputImage else {
    //            return
    //        }
    //        image = Image(uiImage: inputImage)
    
    //immediately saves image that got loaded; creating a duplicate
    
    //UIImageWriteToSavedPhotosAlbum(inputImage, nil, nil, nil)
    
    //    }
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
