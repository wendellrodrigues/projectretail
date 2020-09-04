//
//  Home.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 9/3/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import SwiftUI

struct Home: View {
    
    @EnvironmentObject var session: SessionStore
    
    func logout() {
        session.logout()
    }
    
    var body: some View {
        Button(action: logout) {
            Text("Logout")
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
