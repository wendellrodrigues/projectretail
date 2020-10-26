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
    
    @State var pant: String = "M"
    @State var shirtSize = "M"
    
    @State var sex = "female"

    
    var body: some View {
        
        
        ZStack {
            
            Color(#colorLiteral(red: 0.8017465693, green: 0.9201128859, blue: 1, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 10) {
                Spacer()
                
                Image("femaleSilhouette")
                    .resizable()
                    .frame(width: 40, height: 100, alignment: .center)
                    
                
                
                VStack {
                    Picker(selection: self.$pant, label: Text("Numbers")) {
                        ForEach(WOMENS_PANTS_SIZES) { size in
                            Text("\(size)")
                                .font(.headline)
                        }
                    }

                    
                    Text("Pants Size")
                        .font(.headline)
                        .padding(.bottom, 50)
                }
                
                
                
                ShirtSizePreferences(inheretedSize: session.userSession?.femaleShirtSize ?? "M") { selected in
                    self.shirtSize = selected
                }

                Text("Back")
                    .onTapGesture {
                        if(sizingPreferences.hasSelectedMale == true) {
                            viewRouter.currentPage = "male"
                        }
                        else {
                            viewRouter.currentPage = "sexPreference"
                        }
                    }

                    Text("Finish")
                        .onTapGesture {
                            
                            //Store female sizing prefs to user object
                            //Next time it will attach will be on login
                            session.userSession?.femaleShirtSize = self.shirtSize
                            session.userSession?.femalePantsSize = self.pant
                            
                            //Change viewRouter
                            viewRouter.currentPage = "home"
                            
                            //Update database object
                            StorageService.updateSizingPreferences(
                                userId: session.userSession?.uid ?? "",
                                maleShirtSize: session.userSession?.maleShirtSize ?? "",
                                maleWaistSize: session.userSession?.maleWaistSize ?? 26,
                                maleLengthSize: session.userSession?.maleLengthSize ?? 26,
                                femalePantsSize: self.pant,
                                femaleShirtSize: self.shirtSize
                            )

                            session.hasEnteredSizes = true
                    }
            }
        }
    }
}
        
