//
//  ConfirmPasswordTextField.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 9/26/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import SwiftUI

struct SignUpConfirmPasswordTextField: View {
    
    @Binding var confirmPwd: String
    
    @Binding var typingFirstName: Bool
    @Binding var typingEmail: Bool
    @Binding var typingPwd: Bool
    @Binding var typingConfirmPwd: Bool
    
    var body: some View {
        
        HStack {
            SecureField(TXT_CNFRM_PASS, text: $confirmPwd, onCommit: {self.typingConfirmPwd = false})
                .onTapGesture {
                    self.typingFirstName = false
                    self.typingEmail = false
                    self.typingPwd = false
                    self.typingConfirmPwd = true
                }
                .frame(minWidth: 50, minHeight: 40)
                .disableAutocorrection(true)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                .keyboardType(.emailAddress)
                .font(Font.custom("DMSans-Bold", size: 14.5))
                .padding(.leading, typingConfirmPwd ? 10 : 40)
                .textFieldFocusableArea()
    }
        .overlay(
            HStack {
                Image(systemName: PWD_CONFIRM_ICON)
                    .font(.system(size: 14, weight: .light))
                    .foregroundColor(Color("Primary").opacity(typingConfirmPwd ? 0 : 1))
                    .frame(width: typingConfirmPwd ? 290 : 54, height: typingConfirmPwd ? 4 : 50)
                    .background(Color("Primary").opacity(typingConfirmPwd ? 1 : 0))
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .shadow(color: Color("Primary").opacity(0.3), radius: 10, x: 10, y: 10)
                    .offset(x: typingConfirmPwd ? 10 : -10, y: typingConfirmPwd ? 20 : 0)
                Spacer()
            }
        )
    }
   
}
