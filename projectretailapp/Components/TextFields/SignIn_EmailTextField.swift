//
//  EmailTextField.swift
//  ProjectGrad1
//
//  Created by Wendell Rodrigues on 8/30/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import SwiftUI

struct SignInEmailTextField: View {
    
    @Binding var email: String
    @Binding var typingEmail: Bool
    @Binding var typingPassword: Bool
    
    var body: some View {
        HStack {

            TextField(TXT_EMAIL, text: $email, onCommit: {self.typingEmail = false})
                .onTapGesture {
                    self.typingPassword = false
                    self.typingEmail = true
                }
                .frame(minWidth: 50, minHeight: 40)
                .disableAutocorrection(true)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                .keyboardType(.emailAddress)
                .font(Font.custom("DMSans-Bold", size: 14.5))
                .padding(.leading, typingEmail ? 10 : 40)
                .textFieldFocusableArea()
                
        }
            .overlay(
                HStack {
                    Image(systemName: EMAIL_ICON)
                        .font(.system(size: 14, weight: .light))
                        .foregroundColor(Color("Primary").opacity(typingEmail ? 0 : 1))
                        .frame(width: typingEmail ? 290 : 54, height: typingEmail ? 4 : 50)
                        .background(Color("Primary").opacity(typingEmail ? 1 : 0))
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .shadow(color: Color("Primary").opacity(0.3), radius: 10, x: 10, y: 10)
                        .offset(x: typingEmail ? 10 : -10, y: typingEmail ? 20 : 0)
                        
                    Spacer()
                }
            )
        
    }
}


