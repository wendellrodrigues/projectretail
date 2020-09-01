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
    
    static func registerUser( email: String, password: String,
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
            
            //Locate the userID from the authData
            //guard let userId = authData?.user.uid else { return }
        }
    }   
}
