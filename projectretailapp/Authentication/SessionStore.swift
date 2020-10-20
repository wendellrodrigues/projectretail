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
    @Published var userSession: User?
    @Published var hasEnteredSizes = false
    
    //Change these to master defaults in CONSTANTS.swift
    @Published var maleShirtSize = "M"
    @Published var maleWaistSize = 26
    @Published var maleLengthSize = 26
    
    
    var handle: AuthStateDidChangeListenerHandle?
    
    
    //Listen for user logged in
    func listenAuthenticationState() {
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if let user = user {
                
                let firestoreUserId = Ref.FIRESTORE_DOCUMENT_USERID(userId: user.uid)
                
                firestoreUserId.getDocument { (document, error) in
                    if let dict = document?.data() {
                        guard let decoderUser = try? User.init(fromDictionary: dict) else { return }
                        
                        //Attaches boolean that reads from the database whether a user has entered their size preferences
                        //This is used to route the user to either home page or enter size sequence
                        let enteredSize = dict["hasEnteredSizingPreferences"] as? Bool ?? false
                        self.hasEnteredSizes = enteredSize
                        
                        
                        //Get sizes and store them to user object
                        let maleShirtSize = dict["maleShirtSize"] as? String ?? ""
                        self.maleShirtSize = maleShirtSize
                        
                        let maleWaistSize = dict["maleWaistSize"] as? Int ?? 26
                        self.maleWaistSize = maleWaistSize
                        
                        let maleLengthtSize = dict["maleLengthSize"] as? Int ?? 26
                        self.maleLengthSize = maleLengthtSize
                        
                        
                        self.userSession = decoderUser //Store user to user session
                        self.isLoggedIn = true
                    }
                }

            } else {
                self.isLoggedIn = false
                self.userSession = nil
            }
        })
    }
    
    func logout() {
        do {
            try Auth.auth().signOut() //Will change addStateDidChangeListener
        } catch {
            print(error)
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
