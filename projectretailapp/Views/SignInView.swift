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
    @State var loading = false
    
    @ObservedObject var signinViewModel = SignInViewModel()
    @EnvironmentObject var viewRouter: ViewRouter
    
    func signIn() {
        
        signinViewModel.signin(email: signinViewModel.email, password: signinViewModel.password, completed: { (user) in
            self.clean()
            self.loading = false
        }, onError: { (errorMessage) in
            self.signinViewModel.showAlert = true
            self.signinViewModel.errorString = errorMessage
            self.clean()
            self.typingEmail = false
            self.typingPassword = false
            self.hideKeyboard()
            self.loading = false
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

            ZStack {
        
                Color("Primary")
                    .onTapGesture {
                        hideKeyboard()
                        self.typingEmail = false
                        self.typingPassword = false
                    }
                    .animation(.easeInOut(duration: 0.5))
                
                
                Image("Logo")
                    .resizable()
                    .frame(width:120, height: 250, alignment: .center)
                    .offset(y: -175)
                    .onTapGesture {
                        print("trying to close keyboard")
                        hideKeyboard()
                        self.typingEmail = false
                        self.typingPassword = false
                    }
                
                VStack {
                    SignInTextFields(email: $signinViewModel.email,
                                     password: $signinViewModel.password,
                                     typingEmail: self.$typingEmail,
                                     typingPassword: self.$typingPassword)
                        .padding(.top, 5)
    
                    if(signinViewModel.errorString != "") {
                        Text(signinViewModel.errorString)
                               .modifier(ErrorMessageModifier())
                    }
                    
                    
                    SignUpInButton(
                        label: TXT_SIGN_IN_BUTTON,
                        loading: $loading,
                        action: signIn)
                    
                    CreateAccountText()
                        .onTapGesture {
                            self.viewRouter.currentPage = "register"
                        }
                        .padding(.bottom, 240)
                
                }
            .background(Color.white)
            .frame(minWidth: UIScreen.main.bounds.size.width,  minHeight: 400)
            .cornerRadius(15)
            .offset(y: self.typingEmail || self.typingPassword ? -30 : 300)
            .onTapGesture {
                hideKeyboard()
                self.typingEmail = false
                self.typingPassword = false
            }
            .animation(.easeInOut)

                
        }
        .edgesIgnoringSafeArea(.all)
    }
   
}





