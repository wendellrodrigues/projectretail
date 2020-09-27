//
//  AlreadyHaveAccount.swift
//  ProjectGrad1
//
//  Created by Wendell Rodrigues on 8/31/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import SwiftUI

struct AlreadyHaveAccount: View {
    
    var body: some View {
        HStack {
            Text(TXT_ALREADY_HAVE_ACCOUNT)
                .font(.footnote)
            Spacer()
            Text(TXT_SIGN_IN)
                .font(.system(size: 14, weight: .bold, design: .default))
        }
        .padding([.leading, .trailing], 30)
        .padding(.top, 10)
    }
    
}
