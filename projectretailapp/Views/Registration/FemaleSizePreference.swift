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
        self._pantSize = State(initialValue: sessionStore.userSession?.femalePantsSize ?? "")
        self._shirtSize = State(initialValue: sessionStore.userSession?.femaleShirtSize ?? "")
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
                
                //Silhouette
                Image("femaleSilhouette")
                    .resizable()
                    .frame(width: 50, height: 120, alignment: .center)
                    .padding(.top, -40)
                    .padding(.bottom, 50)
                    
            
                //Pant Size
                VStack {
                    
                    Text("Pant Size")
                        .font(.custom("DMSans-Bold", size: 25))
                        .padding([.top, .bottom], 20)
                        .opacity(0.7)
                    WomensPantSize(pantSize: $pantSize)
                }
                .padding()
                .padding(.bottom, 30)
                .frame(maxWidth: screen.width - 20)
                .background(Color("Primary").opacity(0.2))
                .cornerRadius(30)
   
                //Shirt Size
                ShirtSizePreferences(
                    sex: "female",
                    inheretedSize: session.userSession?.femaleShirtSize ?? "M") { selected in
                    self.shirtSize = selected
                }
                .padding(.top, 10)
  
                LargeButton(label: "Finish", action: finish)
                    .padding(20)
            
            }
        }
    }
}


struct WomensPantSize: View {
    
    @Binding var pantSize: String
    let screen = UIScreen.main.bounds.size
    
    var body: some View {
        HStack {
            //Length
            VStack {
                Image("PantSilhouette")
                    .resizable()
                    .frame(width: 30, height: 80, alignment: .center)
                    .padding(.trailing, 5)
                    .opacity(0.5)
                Text("Length")
                    .font(.custom("DMSans-Bold", size: 17))
                    .opacity(0.6)
            }
            .padding(.trailing, 30)
            Picker(selection: self.$pantSize, label: Text("Numbers")) {
                ForEach(WOMENS_PANTS_SIZES) { size in
                    Text("\(size)")
                        .foregroundColor(Color("Primary"))
                        .font(.custom("DMSans-Bold", size: 16))
                }
            }
            .pickerStyle(WheelPickerStyle())
            .padding(.top, -50)
            .frame(maxWidth: screen.width * 0.6)
            .frame(height: 90)
            .clipped()
        }
    }
}
        
