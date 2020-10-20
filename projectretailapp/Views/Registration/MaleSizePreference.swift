//
//  MaleSizePreference.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 10/16/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import SwiftUI


struct MaleSizePreference: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var sizingPreferences: SizingPreferences
    @EnvironmentObject var session: SessionStore
    
    @State var length: Int = 26
    @State var waist: Int = 26
    
    @State var shirtSize = "M"
    
    
    var body: some View {
        ZStack {
            
            Color(#colorLiteral(red: 0.8017465693, green: 0.9201128859, blue: 1, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 10) {
                Spacer()
                
                Image("maleSilhouette")
                    .resizable()
                    .frame(width: 40, height: 100, alignment: .center)
                    .padding(.top, 30)
                
                GeometryReader { geometry in
                    HStack(spacing: 0) {
                        VStack {
                            Picker(selection: self.$length, label: Text("Numbers")) {
                                ForEach(MENS_LENGTH_SIZES) { length in
                                    Text("\(length)")
                                        .font(.headline)
                                }
                            }
                            .frame(maxWidth: geometry.size.width / 2)
                            .clipped()
                            
                            Text("Length")
                                .font(.headline)
                        }

                        VStack {
                            Picker(selection: self.$waist, label: Text("Numbers")) {
                                ForEach(MENS_WAIST_SIZES) { waist in
                                    Text("\(waist)")
                                        .font(.headline)
                                }
                            }
                            .frame(maxWidth: geometry.size.width / 2)
                            .clipped()

                            Text("Waist")
                                .font(.headline)
                        }
                    }
                }
                
                
                ShirtSizePreferences(selected: $shirtSize)
                    .padding(.top, -200)
                
                
                Text("Length: \(length) , Waist: \(self.waist), Shirt: \(shirtSize)")
                
                Button(action: {
                    
                }) {
                    Text("Update Sizing")
                }.padding(.bottom, 20)
                
                Text("Back")
                    .onTapGesture {
                        viewRouter.currentPage = "sexPreference"
                    }
                if(sizingPreferences.hasSelectedFemale == true) {
                    Text("Next")
                        .onTapGesture {
                            viewRouter.currentPage = "female"
                        }
                }
            }
        }
    }
    
}





