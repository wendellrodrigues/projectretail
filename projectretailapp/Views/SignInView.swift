//
//  ContentView.swift
//  ProjectGrad1
//
//  Created by Wendell Rodrigues on 8/30/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    
    @State var typing: Bool = false
    
    @ObservedObject var signinViewModel = SignInViewModel()
    

    
    func signIn() {
        
        signinViewModel.signin(email: signinViewModel.email, password: signinViewModel.password, completed: { (user) in
            self.clean()
        }, onError: { (errorMessage) in
            self.signinViewModel.showAlert = true
            self.signinViewModel.errorString = errorMessage
            self.clean()
            self.typing = false
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
                        self.typing = false
                        print(self.typing)
                    }
                VStack {
                    SignInTextFields(email: $signinViewModel.email, password: $signinViewModel.password, typing: self.$typing)
                    
                    Text(signinViewModel.errorString)
                           .modifier(ErrorMessageModifier(typing: self.typing))
                    
                    SignInButton(action: signIn)
                    
                    NavigationLink(destination: SignUpView()) {
                         CreateAccountText(typing: $typing)
                        
                    }
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                }
                .offset(y: self.typing ? -100 : 0)
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

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}



