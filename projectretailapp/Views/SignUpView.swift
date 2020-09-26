//
//  SignUpView.swift
//  ProjectGrad1
//
//  Created by Wendell Rodrigues on 8/31/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import SwiftUI

struct SignUpView: View {
    
    @State var typing: Bool = false
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
        ZStack {
            Color
                .black
                .edgesIgnoringSafeArea(.all)
                .opacity(typing ? 0.8 : 0.0)
                .animation(.easeInOut)
                   
           Image("SignUp_Background")
               .resizable()
            .modifier(BackgroundImageModifier(typing: typing))
               .onTapGesture {
                    self.hideKeyboard()
                    self.typing = false
                    self.areErrors = false
                    self.signUpViewModel.errorString = "Passwords must be in between 6 and 20 characters"
                }
            
            VStack {

                
                SignUpTextFields(firstName: $signUpViewModel.firstName, email: $signUpViewModel.email, password: $signUpViewModel.password, confirmedPassword: $signUpViewModel.confirmedPassword, typing: $typing)
                
        
                Text(signUpViewModel.errorString)
                    .modifier(ErrorMessageModifier(typing: self.typing))

                SignUpButton(action: register)
                
                NavigationLink(destination: SignInView()) {
                    AlreadyHaveAccount(typing: $typing)
                }
                .animation(.none)
                .navigationBarTitle("")
                .navigationBarHidden(true)
                
            }
            //.padding(.bottom, typing ? 100 : 0)
            .animation(.easeInOut)

        }
        .navigationBarTitle("Register", displayMode: .inline)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
