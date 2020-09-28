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
    
    @State var falseBool = false
    
    @ObservedObject var signinViewModel = SignInViewModel()
    @ObservedObject var viewRouter: ViewRouter
    
    static let gradientStart = Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))
    static let gradientEnd = Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))
    

    
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
            print(loading)
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
        
                Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))
                    .onTapGesture {
                        print("trying to close keyboard")
                        hideKeyboard()
                        self.typingEmail = false
                        self.typingPassword = false
                    }
                
             
                LottieView(fileName: "Circles")
                    .frame(width: 350, height: 300)
                    .offset(y: -150)
                    .opacity(0.8)
                    .blur(radius: 10)
                    .onTapGesture {
                        print("trying to close keyboard")
                        hideKeyboard()
                        self.typingEmail = false
                        self.typingPassword = false
                    }
                
                
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
                        .padding(.top, 20)
    
                    if(signinViewModel.errorString != "") {
                        Text(signinViewModel.errorString)
                               .modifier(ErrorMessageModifier())
                    }
                    
                    
                    SignInButton(loading: $loading, action: signIn)
                    
                    CreateAccountText()
                        .onTapGesture {
                            print("tapping create account)")
                            self.viewRouter.currentPage = "register"
                        }
                        .padding(.bottom, 240)
                
            }
            .background(Color(#colorLiteral(red: 0.8017465693, green: 0.9201128859, blue: 1, alpha: 1)))
            .cornerRadius(15)
            .frame(minWidth: UIScreen.main.bounds.size.width,  minHeight: 400)
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





