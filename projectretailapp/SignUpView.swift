//
//  SignUpView.swift
//  ProjectGrad1
//
//  Created by Wendell Rodrigues on 8/31/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject var signUpViewModel = SignUpViewModel()
    
    func hideKeyboard() {
           UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    var body: some View {
        ZStack {
            Color
                .black
                .edgesIgnoringSafeArea(.all)
                .opacity(signUpViewModel.typing ? 0.3 : 0.0)
                .animation(.easeInOut)
                   
           Image("SignUp_Background")
               .resizable()
            .modifier(BackgroundImageModifier(typing: signUpViewModel.typing))
               .onTapGesture {
                    self.hideKeyboard()
                    self.signUpViewModel.typing = false
                }
            
            VStack {
                Image("Shopping_Logo")
                    .resizable()
                    .frame(width: signUpViewModel.typing ? 75 : 200, height: signUpViewModel.typing ? 75 : 200)
                    .opacity(signUpViewModel.typing ? 0.8 : 1)
                
                SignUpTextFields(email: $signUpViewModel.email, password: $signUpViewModel.password, confirmedPassword: $signUpViewModel.confirmedPassword, typing: $signUpViewModel.typing)
                
                SignUpButton()
                
                NavigationLink(destination: SignInView()) {
                    AlreadyHaveAccount(typing: $signUpViewModel.typing)
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
                
            }
            .padding(.bottom, signUpViewModel.typing ? 260 : 0)
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
