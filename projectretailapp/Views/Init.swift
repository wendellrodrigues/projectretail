//
//  Init.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 9/3/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import SwiftUI

struct Init: View {
    
   @EnvironmentObject var session: SessionStore
    
    func listen() {
        session.listenAuthenticationState()
        //session.isLoggedIn = false
    }
    
    var body: some View {
        Group {
            if session.isLoggedIn {
                Home()
            } else {
                SignInView()
            }
        }.onAppear(perform: listen)
    }
}

struct Init_Previews: PreviewProvider {
    static var previews: some View {
        Init()
    }
}
