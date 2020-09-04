//
//  SessionStore.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 9/3/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import Foundation
import Combine
import FirebaseAuth

class SessionStore: ObservableObject {
    
    @Published var isLoggedIn = false
    var handle: AuthStateDidChangeListenerHandle?
    
    func listenAuthenticationState() {
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if((user) != nil) {
                self.isLoggedIn = true
            } else {
                self.isLoggedIn = false
            }
        })
    }
    
    func logout() {
        do {
            try Auth.auth().signOut() //Will change addStateDidChangeListener
        } catch {
            
        }
    }
    
    //Stop listening for auth changes
    func unbind() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    deinit {
        unbind()
    }
}
