//
//  Init.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 9/3/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import SwiftUI

struct Init: View {
    
    @State var page = "signin"
    
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var sizingPreferences: SizingPreferences
    @EnvironmentObject var session: SessionStore
    
    func listen() {
        print("viewRouter current page: \(viewRouter.currentPage)")
        session.listenAuthenticationState()
        print("viewRouter current page: \(viewRouter.currentPage)")
    }
    
    var body: some View {
        ZStack {
            if(session.isLoggedIn) {
                HomeView()
            }
            else {
                if(viewRouter.currentPage == "register") { SignUpView() }
                else if(viewRouter.currentPage == "signin") { SignInView() }
            }
        }.onAppear(perform: listen)
    }
}

