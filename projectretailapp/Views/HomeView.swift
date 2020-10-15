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
    
    var body: some View {
        
        if(session.hasEnteredSizes == true) {
            Home()
        } else {
            SexPreference()
        }
        
       
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
