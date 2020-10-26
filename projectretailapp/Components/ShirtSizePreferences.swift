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
    @State var sex = "male"


    let callback: (String) -> ()
    
    func radioGroupCallback(id: String) {
            selected = id
            callback(id)
    }
    
    func checkShirtSize(shirtSize: String) -> Bool {

        let currentMaleSize = session.userSession?.maleShirtSize ?? "M"
        let currentFemaleSize = session.userSession?.femaleShirtSize ?? "M"

        if(self.sex == "male") {
            if(shirtSize == currentMaleSize) { return true }
            return false
        }

        else {
            if(shirtSize == currentFemaleSize) { return true }
            return false
        }
    }
    
    
    
    var body: some View {
        
        VStack {
            
            Text("Shirt Size")
                .font(.headline)
                .padding(.bottom, 20)
        
            HStack {
                
                SizeButton(id: "XS",
                           label: "XS",
                           isMarked: selected == "XS" ? true : false,
                           callback: radioGroupCallback)
                
                SizeButton(id: "S",
                           label: "S",
                           isMarked: selected == "S" ? true : false,
                           callback: radioGroupCallback)
                
                SizeButton(id: "M",
                           label: "M",
                           isMarked: selected == "M" ? true : false,
                           callback: radioGroupCallback)
                
                SizeButton(id: "L",
                           label: "L",
                           isMarked: selected == "L" ? true : false,
                           callback: radioGroupCallback)
                
                SizeButton(id: "XL",
                           label: "XL",
                           isMarked: selected == "XL" ? true : false,
                           callback: radioGroupCallback)
                
                SizeButton(id: "XXL",
                           label: "XXL",
                           isMarked: selected == "XXL" ? true : false,
                           callback: radioGroupCallback)
               
            }
        }
    }
}
