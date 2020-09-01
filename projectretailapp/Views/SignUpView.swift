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
    
    func register() {
        
        if(signUpViewModel.email.isEmpty || signUpViewModel.password.isEmpty || signUpViewModel.confirmedPassword.isEmpty) {
            self.areErrors = true
            signUpViewModel.errorString = "Please fill in all the fields"
            self.clean()
            return
        } else if (signUpViewModel.password != signUpViewModel.confirmedPassword) {
            self.areErrors = true
            signUpViewModel.errorString = "Passwords do not match"
            self.cleanPasswords()
            return
        }
        
        
        signUpViewModel.registerNewUser(
            email: signUpViewModel.email,
            password: signUpViewModel.password,
            completed: { (user) in
                print (user.email)
                self.clean()
                
            //Switch to main app
            
            }) {(errorMessage) in
                print("Error: \(errorMessage)")
                self.areErrors = true
                self.signUpViewModel.errorString = errorMessage
                self.clean()
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
                }
            
            VStack {
                Image("Shopping_Logo")
                    .resizable()
                    .frame(width: typing ? 75 : 200, height: typing ? 75 : 200)
                    .opacity(typing ? 0.8 : 1)
                
                SignUpTextFields(email: $signUpViewModel.email, password: $signUpViewModel.password, confirmedPassword: $signUpViewModel.confirmedPassword, typing: $typing)
                
            
                if(areErrors) {
                    Text(signUpViewModel.errorString)
                        .modifier(ErrorMessageModifier(typing: self.typing))
                } else {
                    Text(PWD_HELP)
                    .modifier(PasswordHelpModifier(typing: self.typing))
                }
        

                SignUpButton(action: register)
                
                NavigationLink(destination: SignInView()) {
                    AlreadyHaveAccount(typing: $typing)
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
                
            }
            .padding(.bottom, typing ? 280 : 0)
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
