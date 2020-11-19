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
    
    //First check to see if the user has selected anything
    //If the user has not selected anything, grab size from the current user object (inhereted)
    func checkShirtSize(shirtSize: String) -> Bool {
        if(selected != "") { return shirtSize == selected }
        return inheretedSize == shirtSize
    }
    
    var body: some View {
        
        VStack {
            
            Text("Shirt Size")
                .font(.custom("DMSans-Bold", size: 25))
                .padding(.bottom, 20)
                .foregroundColor(Color.white)
            
            Image("ShirtSilhouette")
                .resizable()
                .frame(width: 92, height: 100, alignment: .center)
                .padding(.trailing, 5)
                .padding(.bottom, 20)
                .opacity(0.5)
        
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
            .padding(.bottom, 20)
        }
        .padding()
        .frame(maxWidth: screen.width - 20)
        .background(sex == "male" ?  Color("MaleSpecific") : Color("FemaleSpecific"))
        .cornerRadius(30)
    }
}
