//
//  FemaleSizePreference.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 10/16/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import SwiftUI

struct FemaleSizePreference: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var sizingPreferences: SizingPreferences
    @EnvironmentObject var session: SessionStore
    
    var sessionStore: SessionStore
    
    @State var sex = "female"
    
    @State var pantSize: String = ""
    @State var shirtSize: String = ""
    
    let screen = UIScreen.main.bounds.size
    
    init(sessionStore: SessionStore) {
        self.sessionStore = sessionStore
        self._pantSize = State(initialValue: sessionStore.userSession?.femalePantsSize ?? "2")
        self._shirtSize = State(initialValue: sessionStore.userSession?.femaleShirtSize ?? "M")
    }
    
    //Handles which page to return to
    func back() {
        if(sizingPreferences.hasSelectedMale == true) {
            viewRouter.currentPage = "male"
        }
        else {
            viewRouter.currentPage = "sexPreference"
        }
    }
    
    //Finish function for when female preferences have been selected
    //Store female sizing prefs to user object
    //Next time it will attach will be on login
    func finish() {

        if(shirtSize != "") { session.userSession?.femaleShirtSize = self.shirtSize }
        
        if(pantSize != "") { session.userSession?.femalePantsSize = self.pantSize }

        //Change viewRouter
        viewRouter.currentPage = "home"
        
        //Update database object
        StorageService.updateSizingPreferences(
            userId: session.userSession?.uid ?? "",
            maleShirtSize: session.userSession?.maleShirtSize ?? "M",
            maleWaistSize: session.userSession?.maleWaistSize ?? 26,
            maleLengthSize: session.userSession?.maleLengthSize ?? 26,
            femalePantsSize: session.userSession?.femalePantsSize ?? "M",
            femaleShirtSize: session.userSession?.femaleShirtSize ?? "M"
        )
        session.hasEnteredSizes = true
    }
        
        
    
    var body: some View {
        
        ZStack {
            
            //Background
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                
                
                ScrollViewReader { value in
                    
                    //Back Button
                    HStack {
                        Image(systemName: BACK_BUTTON)
                            .font(.custom("DMSans-Bold", size: 30))
                            .foregroundColor(Color("Primary"))
                            .padding(.leading, 20)
                            .onTapGesture { back() }
                        Spacer()
                    }
                    .padding(.top, 70)
                    .padding(.leading, 20)
                    
                    //Pant Silhouette
                    Image("PantSilhouette")
                        .resizable()
                        .frame(width: 70, height: 150)
                        .padding(.bottom, 100)
                        .animation(.spring())
                        .opacity(0.5)
                        .onTapGesture {
                            withAnimation {
                                value.scrollTo(2)
                            }
                        }
                    
                    //Pant Size
                    VStack {
                        WomensPantSize(pantSize: $pantSize)
                    }
                    .padding()
                    .padding(.bottom, 30)
                    .frame(maxWidth: screen.width - 20)
                    .background(Color("TextField_Background"))
                    .cornerRadius(30)
                    
                    //Scroll down button
                    HStack {
                        Spacer()
                        SmallButton(label: "Next", action: {
                            withAnimation {
                                value.scrollTo("shirt", anchor: .center)
                            }
                        })
                        .padding()
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 120)
                    
                    //Shirt Size Title
                    VStack {
                        Text("Shirt Size")
                            .font(.custom("DMSans-Bold", size: 26))
                        Text("Women's")
                            .font(.custom("DMSans-Bold", size: 16))
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .padding(.bottom, 20)
                    
                    
                    //Shirt Size
                    ShirtSizePreferences(
                        sex: "female",
                        inheretedSize: session.userSession?.femaleShirtSize ?? "M") { selected in
                        self.shirtSize = selected
                    }
                    .id("shirt")
                    .padding(.top, 10)
                   
                    LargeButton(label: "Finish", action: finish)
                        .padding(20)
                    
                }
            }
        }
    }
}


struct WomensPantSize: View {
    
    @Binding var pantSize: String
    let screen = UIScreen.main.bounds.size
    
    var body: some View {
        HStack {
            
            VStack(alignment: .leading) {
                Text("Pant Size")
                    .font(.custom("DMSans-Bold", size: 24))
                    .frame(width: 110)
                Text("Women's")
                    .font(.custom("DMSans-Bold", size: 16))
                    .foregroundColor(.gray)
            }
            .padding(.leading, 20)
            .padding()
            
            Picker(selection: self.$pantSize, label: Text("Numbers")) {
                ForEach(WOMENS_PANTS_SIZES) { pantSize in
                    Text("\(pantSize)")
                        .foregroundColor(Color("Primary"))
                        .font(.custom("DMSans-Bold", size: 16))
                        .padding(20)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(width: 200, height: 200)
            .clipped()
            .padding(.trailing, 10)
        }
    }
}
        
