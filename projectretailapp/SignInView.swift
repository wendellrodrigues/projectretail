//
//  ContentView.swift
//  ProjectGrad1
//
//  Created by Wendell Rodrigues on 8/30/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @State var typing: Bool = false
    
    func hideKeyboard() {
           UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    

    var body: some View {
        
        NavigationView {
            ZStack {
                
                Color.black.edgesIgnoringSafeArea(.all)
                    .opacity(typing ? 0.3 : 0.0)
                    .animation(.easeInOut)
                
                Image("SignUp_Background")
                    .resizable()
                    .modifier(BackgroundImageModifier(typing: typing))
                    .onTapGesture {
                        self.hideKeyboard()
                        self.typing = false
                    }
                
                VStack {
                    
                    Image("Shopping_Logo")
                        .resizable()
                        .frame(width: typing ? 100 : 200, height: typing ? 100 : 200)
                        .opacity(typing ? 0 : 1)
                    
                    SignInTextFields(email: $email, password: $password, typing: $typing)
                    
                    SignInButton()
                    
                    NavigationLink(destination: SignUpView()) {
                         CreateAccountText(typing: $typing)
                    }
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                    

                }
                .padding(.bottom, typing ? 300 : 0)
                .animation(.easeInOut)
                
            }

        }
        .accentColor(Color.black)
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.all)
        
    }
    
        
        
        
}

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}



