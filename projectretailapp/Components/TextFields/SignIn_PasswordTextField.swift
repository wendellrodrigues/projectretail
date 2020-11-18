//
//  PasswordTextField.swift
//  ProjectGrad1
//
//  Created by Wendell Rodrigues on 8/31/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import Foundation
import SwiftUI

struct SignInPasswordTextField: View {
    
    @Binding var password: String
    @Binding var typingEmail: Bool
    @Binding var typingPassword: Bool

    var body: some View {
        HStack {
            SecureField(TXT_PWD, text: $password, onCommit: {self.typingPassword = false})
                .onTapGesture {
                    self.typingEmail = false
                    self.typingPassword = true
                }
                .disableAutocorrection(true)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                .font(Font.custom("DMSans-Bold", size: 14.5))
                .padding(.leading, typingPassword ? 10 : 40)
        }
        .overlay(
            HStack {
                Image(systemName: PWD_ICON)
                    .font(.system(size: 14, weight: .light))
                    .foregroundColor(Color("Primary").opacity(typingPassword ? 0 : 1))
                    .frame(width: typingPassword ? 290 : 54, height: typingPassword ? 4 : 50)
                    .background(Color("Primary").opacity(typingPassword ? 1 : 0))
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .shadow(color: Color("Primary").opacity(0.3), radius: 10, x: 10, y: 10)
                    .offset(x: typingPassword ? 10 : -10, y: typingPassword ? 20 : 0)
                Spacer()
            }
        )
    }
}
