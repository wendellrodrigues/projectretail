//
//  ContentView.swift
//  ProjectGrad1
//
//  Created by Wendell Rodrigues on 8/30/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    
    @State var typingEmail: Bool = false
    @State var typingPassword: Bool = false
    
    @State var falseBool = false
    
    @ObservedObject var signinViewModel = SignInViewModel()
    
    static let gradientStart = Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))
    static let gradientEnd = Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))
    

    
    func signIn() {
        
        signinViewModel.signin(email: signinViewModel.email, password: signinViewModel.password, completed: { (user) in
            self.clean()
        }, onError: { (errorMessage) in
            self.signinViewModel.showAlert = true
            self.signinViewModel.errorString = errorMessage
            self.clean()
            self.typingEmail = false
            self.typingPassword = false
            self.hideKeyboard()
        })
    }
    
    func clean() {
        self.signinViewModel.email = ""
        self.signinViewModel.password = ""
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    

    var body: some View {
        
        NavigationView {
            ZStack {
                (Color(#colorLiteral(red: 0.8017465693, green: 0.9201128859, blue: 1, alpha: 1)))
                    .onTapGesture {
                        hideKeyboard()
                        self.typingEmail = false
                        self.typingPassword = false
                    }
                

                Rectangle()
                    .overlay(
                        LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)), Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                    )
                    .frame(height: 450)
                    .offset(y: self.typingEmail || self.typingPassword ? -500 : -250)
                    .animation(.default)
                    .onTapGesture {
                        hideKeyboard()
                        self.typingEmail = false
                        self.typingPassword = false
                    }
                
                
                
                VStack {
                    SignInTextFields(email: $signinViewModel.email,
                                     password: $signinViewModel.password,
                                     typingEmail: self.$typingEmail,
                                     typingPassword: self.$typingPassword)
    
                    Text(signinViewModel.errorString)
                           .modifier(ErrorMessageModifier())
                    
                    SignInButton(action: signIn)
                    
                    NavigationLink(destination: SignUpView()) {
                         CreateAccountText()
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                }
                
            }
            .offset(y: self.typingEmail || self.typingPassword ? -100 : 150)
            .animation(.default)
        }
        .edgesIgnoringSafeArea(.all)
    }
    .animation(.none)
    .accentColor(Color.black)
    .navigationBarTitle("")
    .navigationBarHidden(true)
    .edgesIgnoringSafeArea(.all)
}
}





