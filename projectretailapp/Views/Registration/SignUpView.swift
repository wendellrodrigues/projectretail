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
    @State var loading = false
    @State var areErrors: Bool = false
    @State var success: Bool = false
    
    @ObservedObject var signUpViewModel = SignUpViewModel()
    @EnvironmentObject var viewRouter: ViewRouter
    
    @EnvironmentObject var session: SessionStore
    
    //Hides Keyboard
    func hideKeyboard() {
       UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    
    //Cleans all text fields
    func clean() {
        self.signUpViewModel.firstName = ""
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
                self.loading = false
                self.clean()
                self.success = true
                viewRouter.currentPage = "sexPreference"
                print("changed view to sex preference: \(viewRouter.currentPage)")
            }) {(errorMessage) in
                self.loading = false
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
                
                Color("Primary")
                    .onTapGesture {
                        hideKeyboard()
                        self.typingFirstName = false
                        self.typingEmail = false
                        self.typingPwd = false
                        self.typingConfirmPwd = false
                    }
                
                
                Image("Logo")
                    .resizable()
                    .frame(width: 75, height: 150, alignment: .center)
                    .offset(y: -250)
                    .onTapGesture {
                        print("trying to close keyboard")
                        hideKeyboard()
                        self.typingFirstName = false
                        self.typingEmail = false
                        self.typingPwd = false
                        self.typingConfirmPwd = false
                    }
                
                VStack {
                    SignUpTextFields(firstName: $signUpViewModel.firstName, email: $signUpViewModel.email, password: $signUpViewModel.password, confirmedPassword: $signUpViewModel.confirmedPassword, typingFirstName: self.$typingFirstName, typingEmail: self.$typingEmail,
                        typingPwd: self.$typingPwd,
                        typingConfirmPwd: self.$typingConfirmPwd)
                    
                    Text(signUpViewModel.errorString)
                           .modifier(ErrorMessageModifier())
                    
                    SignUpInButton(
                                label: TXT_SIGN_UP_BUTTON,
                                 loading: $loading,
                                 action: {
                                    register()
                    })
            
                    AlreadyHaveAccount()
                        .onTapGesture {
                            self.viewRouter.currentPage = "signin"
                        }
                        .padding(.bottom, 280)
                }
                .background(Color.white)
                .frame(minWidth: UIScreen.main.bounds.size.width,  minHeight: 400)
                .cornerRadius(15)
                .offset(y:
                        self.typingFirstName ||
                        self.typingEmail ||
                        self.typingPwd ||
                        self.typingConfirmPwd ?
                        -0 : 250)
                .onTapGesture {
                    hideKeyboard()
                    self.typingFirstName = false
                    self.typingEmail = false
                    self.typingPwd = false
                    self.typingConfirmPwd = false
                }
                .animation(.default)
            }
            .edgesIgnoringSafeArea(.all)
            
        }

}
