//
//  CreateAccountText.swift
//  ProjectGrad1
//
//  Created by Wendell Rodrigues on 8/31/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import SwiftUI

struct CreateAccountText: View {
    
    @Binding var typing: Bool
    
    var body: some View {
        HStack {
            Text(TXT_CREATE_ACCOUNT)
                .font(.footnote)
                .foregroundColor(.gray)
            Spacer()
            Text(TXT_SIGN_UP_BUTTON)
                .font(.system(size: 14, weight: .bold, design: .default))
                .foregroundColor(.gray)
                
        }
        .padding([.leading, .trailing], 30)
        .padding(.top, 10)
    }
    
}


