//
//  Authentication.swift
//  projectretailapp
//
//  Created by Wendell Rodrigues on 8/31/20.
//  Copyright © 2020 Wendell. All rights reserved.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseStorage

class AuthService {
    
    static func registerUser(firstName: String, email: String, password: String,
        onSuccess: @escaping(_ user: User) -> Void,
        onError: @escaping(_ errorMessage: String) -> Void
    ) {
        //Firebase.createAccount(username: username, email: email, password: password, imageData: imageData)
        
        //Instance of Auth Class
        Auth.auth().createUser(withEmail: email, password: password) { (authData, error) in //authData and error are sent back after the createUser process
            
            //Handle Errors
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            guard let userId = authData?.user.uid else { return }
            let metadata = StorageMetadata()
            
            StorageService.storeUser(userId: userId, firstName: firstName, email: email, metadata: metadata, onSuccess: onSuccess, onError: onError)
        }
    }
    
    static func signInUser(
        email: String,
        password: String,
        onSuccess: @escaping(_ user: User) -> Void,
        onError: @escaping(_ errorMessage: String) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (authData, error) in
         
            if error != nil {
                print(error!.localizedDescription)
                onError(error!.localizedDescription)
                return
            }
            
            guard let userId = authData?.user.uid else { return }
             
            let firestoreUserId = Ref.FIRESTORE_DOCUMENT_USERID(userId: userId)
             
             firestoreUserId.getDocument { (document, error) in
                 if let dict = document?.data() {
                      guard let decoderUser = try? User.init(fromDictionary: dict)
                      else { return }
                     onSuccess(decoderUser)
                 }
             }
         }
    }
}
