//
//  ShirtSizePreferences.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 10/19/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import SwiftUI

struct ShirtSizePreferences: View {
    
    @EnvironmentObject var session: SessionStore
    @State var selected: String = ""
    @State var sex: String
    
    //Size inhereted from the user object
    var inheretedSize: String
    
    let screen = UIScreen.main.bounds.size
    
    //If user has updated shirt sizing preferences

    let callback: (String) -> ()
    
    func radioGroupCallback(id: String) {
            selected = id
            callback(id)
    }
    
    func getInheretedSize(size: String) -> Int {
        
        if(size == "XS") { return 10 }
        if(size == "S") { return 20 }
        if(size == "M") { return 30 }
        if(size == "L") { return 40 }
        if(size == "XL") { return 50 }
        if(size == "XXL") { return 60 }
        
        else { return 30 }
        
    }
    
    //First check to see if the user has selected anything
    //If the user has not selected anything, grab size from the current user object (inhereted)
    func checkShirtSize(shirtSize: String) -> Bool {
        if(selected != "") { return shirtSize == selected }
        return inheretedSize == shirtSize
    }
    
    var body: some View {
        
        VStack {
            
            Image("ShirtSilhouette")
                .resizable()
                .frame(width: 220 + CGFloat(getInheretedSize(size: selected)), height: 270 + CGFloat(getInheretedSize(size: selected)), alignment: .center)
                .padding(.trailing, 5)
                .padding(.bottom, 50 - CGFloat(getInheretedSize(size: selected)))
                .opacity(0.5)
                .animation(.spring())
        
            HStack {
                
                SizeButton(id: "XS",
                           label: "XS",
                           isMarked: checkShirtSize(shirtSize: "XS"),
                           callback: radioGroupCallback)
                    .padding([.top, .bottom], 20)
                
                SizeButton(id: "S",
                           label: "S",
                           isMarked: checkShirtSize(shirtSize: "S"),
                           callback: radioGroupCallback)
                
                SizeButton(id: "M",
                           label: "M",
                           isMarked: checkShirtSize(shirtSize: "M"),
                           callback: radioGroupCallback)
                
                SizeButton(id: "L",
                           label: "L",
                           isMarked: checkShirtSize(shirtSize: "L"),
                           callback: radioGroupCallback)
                
                SizeButton(id: "XL",
                           label: "XL",
                           isMarked: checkShirtSize(shirtSize: "XL") ,
                           callback: radioGroupCallback)
                
                SizeButton(id: "XXL",
                           label: "XXL",
                           isMarked: checkShirtSize(shirtSize: "XXL") ,
                           callback: radioGroupCallback)
            }
            .frame(maxWidth: screen.width - 20)
            .background(Color("TextField_Background"))
            .cornerRadius(30)
            .padding(20)
            .padding([.top, .bottom], 20)
        }
    }
}
