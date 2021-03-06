//
//  SignUp_EmailTextField.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 9/26/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import SwiftUI

struct SignUpEmailTextField: View {
    
    @Binding var email: String
    
    @Binding var typingFirstName: Bool
    @Binding var typingEmail: Bool
    @Binding var typingPwd: Bool
    @Binding var typingConfirmPwd: Bool
    
    var body: some View {
        
        HStack {
            TextField(TXT_EMAIL, text: $email, onCommit: {self.typingEmail = false})
                .onTapGesture {
                    self.typingFirstName = false
                    self.typingEmail = true
                    self.typingPwd = false
                    self.typingConfirmPwd = false
                }
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


