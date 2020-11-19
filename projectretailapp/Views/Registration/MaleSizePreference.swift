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
    
    var sessionStore: SessionStore

    @State var sex = "male"
    
    @State var length: Int = 0
    @State var waist: Int = 0
    @State var shirtSize: String = ""
    
    let screen = UIScreen.main.bounds.size
    
    init(sessionStore: SessionStore) {
        self.sessionStore = sessionStore
        self._length = State(initialValue: sessionStore.userSession?.maleLengthSize ?? 0)
        self._waist = State(initialValue: sessionStore.userSession?.maleLengthSize ?? 0)
        self._shirtSize = State(initialValue: sessionStore.userSession?.maleShirtSize ?? "")
    }
    
    @State var updatedShirtSize = false
    
    //Store male sizing to user object
    //Next time it will attach will be on login
    func didSelectFemale() {
        if(shirtSize != "") { session.userSession?.maleShirtSize = self.shirtSize }
        if(length != 0) { session.userSession?.maleWaistSize = self.waist }
        if(waist != 0) { session.userSession?.maleLengthSize = self.length }
        viewRouter.currentPage = "female"
    }
    
    func didNotSelectFemale() {
        viewRouter.currentPage = "home"
        
        //Change Session values if they have been changed
        if(shirtSize != "") { session.userSession?.maleShirtSize = self.shirtSize }
        if(length != 0) { session.userSession?.maleWaistSize = self.waist }
        if(waist != 0) { session.userSession?.maleLengthSize = self.length}

        StorageService.updateMaleOnlySizingPreferences(
            userId: session.userSession?.uid ?? "",
            maleShirtSize: session.userSession?.maleShirtSize ?? "M",
            maleWaistSize: session.userSession?.maleWaistSize ?? 26,
            maleLengthSize: session.userSession?.maleLengthSize ?? 26)

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
                        .onTapGesture { viewRouter.currentPage = "sexPreference" }
                    Spacer()
                }
                .padding(.top, 70)
                .padding(.leading, 20)
                
                //Silhouette
                Image("maleSilhouette")
                    .resizable()
                    .frame(width: 50, height: 120, alignment: .center)
                    .padding(.top, -40)
                    .padding(.bottom, 50)
                    
                //Pant Sizes
                VStack {
                    Text("Pant Sizes")
                        .font(.custom("DMSans-Bold", size: 25))
                        .padding([.top, .bottom], 20)
                        .opacity(0.7)
                    PantWaist(waist: $waist)
                        .padding(.bottom, 30)
                    PantLength(length: $length)
                        .padding(.bottom, 15)

                }
                .padding()
                .padding(.bottom, 30)
                .frame(maxWidth: screen.width - 20)
                .background(Color("Primary").opacity(0.2))
                .cornerRadius(30)
                
                
                //Shirt Size
                ShirtSizePreferences(sex: sex, inheretedSize: session.userSession?.maleShirtSize ?? "M") { selected in
                    self.updatedShirtSize = true //So does not set back to M
                    self.shirtSize = selected
                }
                .padding(.top, 10)
                
                    
                //Continue / Finish Button
                if(sizingPreferences.hasSelectedFemale == true) {
                    LargeButton(label: "Next", action: { didSelectFemale() })
                        .padding(20)
                } else {
                    LargeButton(label: "Finish", action: { didNotSelectFemale()})
                        .padding(20)
                }
            }
        }
    }
    
}


struct PantWaist: View {
    
    @Binding var waist: Int

    let screen = UIScreen.main.bounds.size

    var body: some View {
        
        HStack {
            //Length
            VStack {

                Rectangle()
                    .frame(width: 25, height: 5)
                    .foregroundColor(Color("Primary"))
                    .cornerRadius(5)
                
                Image("PantSilhouette")
                    .resizable()
                    .frame(width: 30, height: 80, alignment: .center)
                    .padding(.trailing, 5)
                    .opacity(0.5)
               
                Text("Waist")
                    .font(.custom("DMSans-Bold", size: 17))
                    .opacity(0.6)
            }
            .padding(.trailing, 30)
            Picker(selection: self.$waist, label: Text("Numbers")) {
                ForEach(MENS_WAIST_SIZES) { waist in
                    Text("\(waist)")
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



struct PantLength: View {
    
    @Binding var length: Int
    
    let screen = UIScreen.main.bounds.size
    
    var body: some View {
        HStack {
            //Length
            VStack {
                HStack {
                    Image("PantSilhouette")
                        .resizable()
                        .frame(width: 30, height: 80, alignment: .center)
                        .padding(.trailing, 5)
                        .opacity(0.5)
                    Rectangle()
                        .frame(width: 5, height: 70)
                        .foregroundColor(Color("Primary"))
                        .cornerRadius(5)
                    //Spacer()
                }
                Text("Length")
                    .font(.custom("DMSans-Bold", size: 17))
                    .opacity(0.6)
            }
            .padding(.trailing, 30)
            Picker(selection: self.$length, label: Text("Numbers")) {
                ForEach(MENS_LENGTH_SIZES) { length in
                    Text("\(length)")
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









