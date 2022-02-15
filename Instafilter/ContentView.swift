//
//  ContentView.swift
//  Instafilter
//
//  Created by Ken Muyesu on 15/02/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var blurAmount = 0.0
    //    {
    //        didSet {
    //            print("New value is \(blurAmount)")
    //        }
    //    }
    
    var body: some View {
        VStack {
            Text("Hello, world!")
                .blur(radius: blurAmount)
            
            
            Slider(value: $blurAmount, in: 0...10)
                .onChange(of: blurAmount) { newValue in
                    print("New value is \(newValue)")
                }
            
            //            Button("Random Blur") {
            //                blurAmount = Double.random(in: 1...10)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
