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
        
        UIPickerView.appearance().tintColor = .red
        
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
                
                
                ScrollViewReader { value in
                    
                    //Back Button
                    HStack(alignment: .center) {
                        Image(systemName: BACK_BUTTON)
                            .font(.custom("DMSans-Bold", size: 30))
                            .foregroundColor(Color("Primary"))
                            .padding(.leading, 20)
                            .onTapGesture { viewRouter.currentPage = "sexPreference" }
                        Spacer()
                    }
                    .padding(.top, 70)
                    .padding(.leading, 20)
                    
   
                    //Pant Silhouette
                    Image("PantSilhouette")
                        .resizable()
                        .frame(width: 70 + (CGFloat(self.waist)), height: 150 + (CGFloat(self.length)), alignment: .center)
                        //.padding(.top, 100)
                        .padding(.bottom, 100 - CGFloat(self.length))
                        .animation(.spring())
                        .opacity(0.5)
                        .onTapGesture {
                            withAnimation {
                                value.scrollTo(2)
                            }
                        }
                        
                    //Pant Sizes
                    VStack {
                        PantWaist(waist: $waist)
                            .padding(.bottom, 30)
                        PantLength(length: $length)
                            .padding(.bottom, -15)
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
                        Text("Men's")
                            .font(.custom("DMSans-Bold", size: 16))
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .padding(.bottom, 20)
                   
                    
                    //Shirt Size
                    ShirtSizePreferences(sex: sex, inheretedSize: session.userSession?.maleShirtSize ?? "M") { selected in
                        self.updatedShirtSize = true //So does not set back to M
                        self.shirtSize = selected
                    }
                    .id("shirt")
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
    
}


struct PantWaist: View {
    
    @Binding var waist: Int

    let screen = UIScreen.main.bounds.size

    var body: some View {
        
        HStack {
            
            VStack {
                Text("Waist")
                    .font(.custom("DMSans-Bold", size: 26))
                    .frame(width: 110)
                Text("Men's")
                    .font(.custom("DMSans-Bold", size: 16))
                    .foregroundColor(.gray)
            }
            .padding()
        
            Picker(selection: self.$waist, label: Text("Numbers")) {
                ForEach(MENS_WAIST_SIZES) { waist in
                    HStack {
                        Text("\(waist)")
                            .foregroundColor(Color("Primary"))
                            .font(.custom("DMSans-Bold", size: waist == self.waist ? 20 : 16))
                            .rotationEffect(Angle(degrees: 90))
                            .padding(.leading, waist == self.waist ? 10 : 0)
                        Rectangle()
                            .frame(width: waist == self.waist ? 20 : 10, height: 3)
                            .foregroundColor(Color("Primary"))
                            .cornerRadius(2)
                            .padding(.leading, waist == self.waist ? 5 : 5)
                    }
                }
            }
            .rotationEffect(Angle(degrees: -90))
            .pickerStyle(WheelPickerStyle())
            .frame(width: 200, height: 100)
            .clipped()
            .padding(.trailing, 10)
        }
        
    }
}

struct PantLength: View {
    
    @Binding var length: Int

    let screen = UIScreen.main.bounds.size

    var body: some View {
        
        HStack {
            
            VStack {
                Text("Length")
                    .font(.custom("DMSans-Bold", size: 26))
                    .frame(width: 110)
                Text("Men's")
                    .font(.custom("DMSans-Bold", size: 16))
                    .foregroundColor(.gray)
            }
            .padding()
        
            Picker(selection: self.$length, label: Text("Numbers")) {
                ForEach(MENS_LENGTH_SIZES) { waist in
                    HStack {
                        Text("\(length)")
                            .foregroundColor(Color("Primary"))
                            .font(.custom("DMSans-Bold", size: waist == self.length ? 20 : 16))
                            .rotationEffect(Angle(degrees: 90))
                            .padding(.leading, waist == self.length ? 10 : 0)
                        Rectangle()
                            .frame(width: waist == self.length ? 20 : 10, height: 3)
                            .foregroundColor(Color("Primary"))
                            .cornerRadius(2)
                            .padding(.leading, waist == self.length ? 5 : 5)
                    }
                }
            }
            .rotationEffect(Angle(degrees: -90))
            .pickerStyle(WheelPickerStyle())
            .frame(width: 200, height: 100)
            .clipped()
            .padding(.trailing, 10)
        }
        
    }
}
