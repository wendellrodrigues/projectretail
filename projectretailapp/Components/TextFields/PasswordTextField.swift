//
//  PasswordTextField.swift
//  ProjectGrad1
//
//  Created by Wendell Rodrigues on 8/31/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import Foundation
import SwiftUI

struct PasswordTextField: View {
    
    @Binding var password: String
    @Binding var typing: Bool
    
    //If confirmed password, use different text
    var confirmed: Bool
    
    var body: some View {
        HStack {
            Image(systemName: PWD_ICON)
                .modifier(IconFieldsModifier(typing: typing))
                .padding(.leading, 4)
            SecureField(confirmed ? TXT_CNFRM_PASS : TXT_PWD, text: $password, onCommit: {self.typing = false})
                .disableAutocorrection(true)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                .font(.system(size: 14.5, weight: .medium, design: .default))
                .onTapGesture {
                    self.typing = true
                }


        }
        
       
    }
}
