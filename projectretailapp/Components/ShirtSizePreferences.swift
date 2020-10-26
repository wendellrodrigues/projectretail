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
    
    //Size inhereted from the user object
    var inheretedSize: String

    let callback: (String) -> ()
    
    func radioGroupCallback(id: String) {
            selected = id
            callback(id)
    }
    
    //First check to see if the user has selected anything
    //If the user has not selected anything, grab size from the current user object (inhereted)
    func checkShirtSize(shirtSize: String) -> Bool {
        if(selected != "") { return shirtSize == selected }
        return inheretedSize == shirtSize
    }
    
    var body: some View {
        
        VStack {
            
            Text("Shirt Size")
                .font(.headline)
                .padding(.bottom, 20)
        
            HStack {
                
                SizeButton(id: "XS",
                           label: "XS",
                           isMarked: checkShirtSize(shirtSize: "XS"),
                           callback: radioGroupCallback)
                
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
        }
    }
}
