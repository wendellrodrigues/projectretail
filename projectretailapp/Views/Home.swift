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
          
        VStack {
            Spacer()
            Text("Welcome, \(session.userSession!.firstName)")
                .font(.largeTitle)
                .fontWeight(.bold)
            .padding(.bottom)
            Button(action: Api(session: self.session).connectUser) {
                Text("Connect User")
            }.padding(.bottom)
            Button(action: Api(session: self.session).disconnectUser) {
                Text("Disconnect User")
                    .padding(.bottom)
            }.padding(.bottom)
            Spacer()
            Button(action: {
                self.logout()
                Api(session: self.session).disconnectUser()
            }) {
               Text("Logout")
            }.padding(.bottom)
        }.padding()
       
    }
}
    


//struct Home_Previews: PreviewProvider {
//    static var previews: some View {
//        Home()
//    }
//}

