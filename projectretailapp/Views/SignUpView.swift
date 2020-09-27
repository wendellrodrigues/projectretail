//
//  SignUpView.swift
//  ProjectGrad1
//
//  Created by Wendell Rodrigues on 8/31/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import SwiftUI

struct SignUpView: View {
    
    @State var typingFirstName: Bool = false
    @State var typingEmail: Bool = false
    @State var typingPwd: Bool = false
    @State var typingConfirmPwd: Bool = false
    
    
    @State var areErrors: Bool = false
    
    @ObservedObject var signUpViewModel = SignUpViewModel()
    
    //Hides Keyboard
    func hideKeyboard() {
       UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    
    //Cleans all text fields
    func clean() {
        self.signUpViewModel.email = ""
        self.signUpViewModel.password = ""
        self.signUpViewModel.confirmedPassword = ""
    }
    
    //Cleans only passwords
    func cleanPasswords() {
        self.signUpViewModel.password = ""
        self.signUpViewModel.confirmedPassword = ""
    }
    
    
    //Utilize SignUpViewModel register function
    //Clean fields
    func register() {
        signUpViewModel.registerNewUser(
            firstName: signUpViewModel.firstName,
            email: signUpViewModel.email,
            password: signUpViewModel.password,
            completed: { (user) in
                self.clean()
                
                //Switch to main app
            
            }) {(errorMessage) in
                self.areErrors = true
                self.signUpViewModel.errorString = errorMessage
                if(errorMessage == "Passwords do not match") {
                    self.cleanPasswords()
                } else {
                    self.clean()
                }
            }
    }
    
    
    var body: some View {
        
        NavigationView {
            ZStack {
                (Color(#colorLiteral(red: 0.8017465693, green: 0.9201128859, blue: 1, alpha: 1)))
                    .onTapGesture {
                        hideKeyboard()
                        self.typingFirstName = false
                        self.typingEmail = false
                        self.typingPwd = false
                        self.typingConfirmPwd = false
                    }
                
                VStack {
                    SignUpTextFields(firstName: $signUpViewModel.firstName, email: $signUpViewModel.email, password: $signUpViewModel.password, confirmedPassword: $signUpViewModel.confirmedPassword, typingFirstName: self.$typingFirstName, typingEmail: self.$typingEmail, typingPwd: self.$typingPwd, typingConfirmPwd: self.$typingConfirmPwd)
                    
                    Text(signUpViewModel.errorString)
                           .modifier(ErrorMessageModifier())
                    
                    SignUpButton(action: register)
                    
                    NavigationLink(destination: SignInView()) {
                        AlreadyHaveAccount()
                    }
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                }
                .edgesIgnoringSafeArea(.all)
                .offset(y:
                        self.typingFirstName ||
                        self.typingEmail ||
                        self.typingPwd ||
                        self.typingConfirmPwd ?
                        -110 : 150)
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



























//
//.modifier(BackgroundImageModifier(typing: typing))
//   .onTapGesture {
//        self.hideKeyboard()
//        self.typing = false
//        self.areErrors = false
//        self.signUpViewModel.errorString = "Passwords must be in between 6 and 20 characters"
//    }
//
//VStack {
//
//
//    SignUpTextFields(firstName: $signUpViewModel.firstName, email: $signUpViewModel.email, password: $signUpViewModel.password, confirmedPassword: $signUpViewModel.confirmedPassword, typing: $typing)
//
//
//    Text(signUpViewModel.errorString)
//        .modifier(ErrorMessageModifier())
//
//    SignUpButton(action: register)
//
//    NavigationLink(destination: SignInView()) {
//        AlreadyHaveAccount(typing: $typing)
//    }
//    .animation(.none)
//    .navigationBarTitle("")
//    .navigationBarHidden(true)
