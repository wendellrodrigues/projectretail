//
//  HomeView.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 10/14/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var session: SessionStore
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var sizingPreferences: SizingPreferences

    @State var male: Bool = false
    
    
    var body: some View {
        if(session.hasEnteredSizes == true) {
            if(viewRouter.currentPage == "sexPreference") { SexPreference() }
            else if(viewRouter.currentPage == "male") { MaleSizePreference(sessionStore: session)}
            else if(viewRouter.currentPage == "female") { FemaleSizePreference(sessionStore: session) }
            else { Home() }
        } else {
            if(viewRouter.currentPage == "sexPreference") { SexPreference() }
            else if(viewRouter.currentPage == "male") { MaleSizePreference(sessionStore: session) }
            else if(viewRouter.currentPage == "female") { FemaleSizePreference(sessionStore: session) }
            else { SexPreference() }
        }

    }
}
