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
    @ObservedObject var signUpViewModel = SignUpViewModel()
    
    func hideKeyboard() {
           UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func register() {
        signUpViewModel.registerNewUser(
            email: signUpViewModel.email,
            password: signUpViewModel.password,
            completed: { (user) in
                print (user.email)
                //self.clean()
            //Switch to main app
            
            }) {(errorMessage) in
                print("Error: \(errorMessage)")
                self.signUpViewModel.showAlert = true
                self.signUpViewModel.errorString = errorMessage
                //self.clean()
            }
    }
    
    var body: some View {
        ZStack {
            Color
                .black
                .edgesIgnoringSafeArea(.all)
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
                    .frame(width: typing ? 75 : 200, height: typing ? 75 : 200)
                    .opacity(typing ? 0.8 : 1)
                
                SignUpTextFields(email: $signUpViewModel.email, password: $signUpViewModel.password, confirmedPassword: $signUpViewModel.confirmedPassword, typing: $typing)
                
                SignUpButton(action: register)
                
                NavigationLink(destination: SignInView()) {
                    AlreadyHaveAccount(typing: $typing)
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
                
            }
            .padding(.bottom, typing ? 260 : 0)
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
