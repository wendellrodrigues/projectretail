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
    
    @ObservedObject var viewRouter: ViewRouter
    @ObservedObject var sizingPrefs: SizingPreferences
    
    @EnvironmentObject var session: SessionStore
    

    func listen() {
        session.listenAuthenticationState()
    }
    
    var body: some View {
        ZStack {
            if(session.isLoggedIn) {
                HomeView()
            }
            else {
                if(viewRouter.currentPage == "register") { SignUpView(viewRouter: viewRouter, sizingPrefs: sizingPrefs)}
                else if(viewRouter.currentPage == "signin") { SignInView(viewRouter: viewRouter) }
            }
        }.onAppear(perform: listen)
    }
}

