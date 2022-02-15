//
//  ContentView.swift
//  Instafilter
//
//  Created by Ken Muyesu on 15/02/2022.
//

import SwiftUI

struct ContentView: View {
//    @State private var blurAmount = 0.0
    
    //    {
    //        didSet {
    //            print("New value is \(blurAmount)")
    //        }
    //    }
    
    @State private var showingConfirmation = false
    @State private var backgroundColor = Color.white
    
    var body: some View {
        Text("Hello, world!")
            .frame(width: 300, height: 300)
            .background(backgroundColor)
            .onTapGesture {
                showingConfirmation = true
            }
        
            .confirmationDialog("Change background", isPresented: $showingConfirmation) {
                Button("Red") { backgroundColor = .red }
                Button("Green") { backgroundColor = .green }
                Button("Blue") { backgroundColor = .blue }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Select a new color")
            }
//        VStack {
//            Text("Hello, world!")
//                .blur(radius: blurAmount)
//
//
//            Slider(value: $blurAmount, in: 0...10)
//                .onChange(of: blurAmount) { newValue in
//                    print("New value is \(newValue)")
//                }
//
//                        Button("Random Blur") {
//                            blurAmount = Double.random(in: 1...10)
//        }
  }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
