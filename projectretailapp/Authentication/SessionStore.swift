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
    @Published var lastUserId: String = ""
    @Published var userSession: User?
    @Published var hasEnteredSizes = false
    
    var handle: AuthStateDidChangeListenerHandle?
    
    //Listen for user logged in
    func listenAuthenticationState() {
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if let user = user {
                
                let firestoreUserId = Ref.FIRESTORE_DOCUMENT_USERID(userId: user.uid)
                
                firestoreUserId.getDocument { (document, error) in
                    if let dict = document?.data() {
                        guard let decoderUser = try? User.init(fromDictionary: dict) else { return }
       
                        //Get sizes from database
                        let enteredSize = dict["hasEnteredSizingPreferences"] as? Bool ?? false
                        let maleShirtSize = dict["maleShirtSize"] as? String ?? DEFAULT_MENS_SHIRT
                        let maleWaistSize = dict["maleWaistSize"] as? Int ?? DEFAULT_MENS_WAIST
                        let maleLengthSize = dict["maleLengthSize"] as? Int ?? DEFAULT_MENS_LENGTH
                        let femalePantsSize = dict["femalePantsSize"] as? String ?? DEFAULT_WOMENS_PANTS
                        let femaleShirtSize = dict["femaleShirtSize"] as? String ?? DEFAULT_WOMENS_SHIRT
                        
                        //Store user to user session
                        self.userSession = decoderUser
                        
                        //Store them to current user object
                        self.userSession?.maleShirtSize = maleShirtSize
                        self.userSession?.maleWaistSize = maleWaistSize
                        self.userSession?.maleLengthSize = maleLengthSize
                        self.userSession?.femaleShirtSize = femaleShirtSize
                        self.userSession?.femalePantsSize = femalePantsSize
                        self.userSession?.hasEnteredSizingPreferences = enteredSize
                        
                        //Remove later when not needed
                        self.hasEnteredSizes = enteredSize
 
                        //Change is logged in to true
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
            lastUserId = userSession?.uid ?? ""
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
