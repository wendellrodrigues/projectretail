//
//  ShirtSizePreferences.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 10/19/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import SwiftUI

struct ShirtSizePreferences: View {
    
    @State var XS_Selected: Bool = false
    @State var S_Selected: Bool = false
    @State var M_Selected: Bool = true
    @State var L_Selected: Bool = false
    @State var XL_Selected: Bool = false
    @State var XXL_Selected: Bool = false
    
    @Binding var selected: String
    
    @State var tap = false
    @State var press = false
    
    
    var body: some View {
        
        VStack {
            
            Text("Shirt Size")
                .font(.headline)
                .padding(.bottom, 20)
        
            HStack {
                SizeButton(isSelected: $XS_Selected, label: "XS")
                    .gesture(
                        LongPressGesture(minimumDuration: 0.1, maximumDistance: 10).onChanged { value in
                            haptic(type: .success)
                            selectSize(size: "XS")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                self.tap = false
                            }
                            
                        }.onEnded { value in
                            self.press.toggle()
                        }
                        
                    )
                SizeButton(isSelected: $S_Selected, label: "S")
                    .gesture(
                        LongPressGesture(minimumDuration: 0.1, maximumDistance: 10).onChanged { value in
                            haptic(type: .success)
                            selectSize(size: "S")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                self.tap = false
                            }
                            
                        }.onEnded { value in
                            self.press.toggle()
                        }
                        
                    )
                SizeButton(isSelected: $M_Selected, label: "M")
                    .gesture(
                        LongPressGesture(minimumDuration: 0.1, maximumDistance: 10).onChanged { value in
                            haptic(type: .success)
                            selectSize(size: "M")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                self.tap = false
                            }
                            
                        }.onEnded { value in
                            self.press.toggle()
                        }
                        
                    )
                SizeButton(isSelected: $L_Selected, label: "L")
                    .gesture(
                        LongPressGesture(minimumDuration: 0.1, maximumDistance: 10).onChanged { value in
                            haptic(type: .success)
                            selectSize(size: "L")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                self.tap = false
                            }
                            
                        }.onEnded { value in
                            self.press.toggle()
                        }
                        
                    )
                SizeButton(isSelected: $XL_Selected, label: "XL")
                    .gesture(
                        LongPressGesture(minimumDuration: 0.1, maximumDistance: 10).onChanged { value in
                            haptic(type: .success)
                            selectSize(size: "XL")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                self.tap = false
                            }
                            
                        }.onEnded { value in
                            self.press.toggle()
                        }
                        
                    )
                SizeButton(isSelected: $XXL_Selected, label: "XXL")
                    .gesture(
                        LongPressGesture(minimumDuration: 0.1, maximumDistance: 10).onChanged { value in
                            haptic(type: .success)
                            selectSize(size: "XXL")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                self.tap = false
                            }
                            
                        }.onEnded { value in
                            self.press.toggle()
                        }
                        
                    )
            }
        }
    
    }
    
    func selectSize(size: String) {
        
        self.selected = size
        
        if(size == "XS") {
            self.XS_Selected = true
            self.S_Selected = false
            self.M_Selected = false
            self.L_Selected = false
            self.XL_Selected = false
            self.XXL_Selected = false
        }
        
        if(size == "S") {
            self.XS_Selected = false
            self.S_Selected = true
            self.M_Selected = false
            self.L_Selected = false
            self.XL_Selected = false
            self.XXL_Selected = false
        }
        
        if(size == "M") {
            self.XS_Selected = false
            self.S_Selected = false
            self.M_Selected = true
            self.L_Selected = false
            self.XL_Selected = false
            self.XXL_Selected = false
        }
        
        if(size == "L") {
            self.XS_Selected = false
            self.S_Selected = false
            self.M_Selected = false
            self.L_Selected = true
            self.XL_Selected = false
            self.XXL_Selected = false
        }
        
        if(size == "XL") {
            self.XS_Selected = false
            self.S_Selected = false
            self.M_Selected = false
            self.L_Selected = false
            self.XL_Selected = true
            self.XXL_Selected = false
        }
        
        if(size == "XXL") {
            self.XS_Selected = false
            self.S_Selected = false
            self.M_Selected = false
            self.L_Selected = false
            self.XL_Selected = false
            self.XXL_Selected = true
        }

    }
}


